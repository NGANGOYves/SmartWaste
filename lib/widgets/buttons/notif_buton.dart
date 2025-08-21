// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycleapp/views/account/CollecteDomicilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationCollecteButton extends StatefulWidget {
  final String username;

  const NotificationCollecteButton({super.key, required this.username});

  @override
  State<NotificationCollecteButton> createState() =>
      _NotificationCollecteButtonState();
}

class _NotificationCollecteButtonState
    extends State<NotificationCollecteButton> {
  Set<String> _seenKeys = {};
  Set<String> _currentKeys = {};
  bool _prefsLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadSeenKeys();
  }

  Future<void> _loadSeenKeys() async {
    final prefs = await SharedPreferences.getInstance();
    final seenList = prefs.getStringList('seen_keys_${widget.username}') ?? [];
    _seenKeys = seenList.toSet();
    setState(() {
      _prefsLoaded = true;
    });
  }

  Future<void> _saveSeenKeys() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      'seen_keys_${widget.username}',
      _seenKeys.toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_prefsLoaded) {
      return const SizedBox(); // or a loading spinner
    }

    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('collectes_domicile')
              .where('user', isEqualTo: widget.username)
              .orderBy('createdAt', descending: true)
              .snapshots(),
      builder: (context, snapshot) {
        int newCount = 0;
        String? latestStatus;
        Color statusColor = Colors.grey;
        final newKeys = <String>{};

        if (snapshot.hasData) {
          final docs = snapshot.data!.docs;

          for (var doc in docs) {
            final docId = doc.id;
            final status = doc['status'] ?? '';
            final key = '$docId-$status';

            newKeys.add(key);
            if (!_seenKeys.contains(key)) {
              newCount++;
            }
          }

          _currentKeys = newKeys;

          if (docs.isNotEmpty) {
            latestStatus = docs.first['status'] ?? '';
            if (latestStatus == 'refusée') {
              statusColor = Colors.red;
            } else if (latestStatus == 'acceptée') {
              statusColor = Colors.green;
            }
          }
        }

        return InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            _seenKeys.addAll(_currentKeys);
            await _saveSeenKeys();
            setState(() {}); // update the badge

            await Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) => CollecteDomicilePage(username: widget.username),
              ),
            );

            // After returning, mark again (in case anything new loaded while on page)
            _seenKeys.addAll(_currentKeys);
            await _saveSeenKeys();
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.notifications, size: 28),
                    if (newCount > 0)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Text(
                            '$newCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                // if (latestStatus != null)
                //   Padding(
                //     padding: const EdgeInsets.only(top: 4.0),
                //     child: Text(
                //       latestStatus,
                //       style: TextStyle(
                //         color: statusColor,
                //         fontSize: 12,
                //         fontWeight: FontWeight.w600,
                //       ),
                //     ),
                //   ),
              ],
            ),
          ),
        );
      },
    );
  }
}
