// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollecteDomicilePage extends StatefulWidget {
  final String username; // Ex: 'Adams'

  const CollecteDomicilePage({super.key, required this.username});

  @override
  State<CollecteDomicilePage> createState() => _CollecteDomicilePageState();
}

class _CollecteDomicilePageState extends State<CollecteDomicilePage> {
  late Future<List<Map<String, dynamic>>> _collectesFuture;

  Future<List<Map<String, dynamic>>> _getCollectes() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('collectes_domicile')
            .where('user', isEqualTo: widget.username)
            .orderBy('createdAt', descending: true)
            .get();

    return snapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  void initState() {
    super.initState();
    _collectesFuture = _getCollectes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Mes collectes à domicile'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _collectesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.green),
            );
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur : ${snapshot.error}'));
          }

          final collectes = snapshot.data ?? [];

          if (collectes.isEmpty) {
            return const Center(child: Text('Aucune collecte trouvée'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: collectes.length,
            itemBuilder: (context, index) {
              final collecte = collectes[index];

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildRow(
                        Icons.location_on,
                        collecte['adresse'] ?? 'Adresse inconnue',
                      ),
                      _buildRow(
                        Icons.calendar_today,
                        'Date : ${collecte['date'] ?? ''}',
                      ),
                      _buildRow(
                        Icons.info_outline,
                        'Statut : ${collecte['status'] ?? ''}',
                      ),
                      _buildRow(
                        Icons.category,
                        'Types : ${_formatTypes(collecte['types'])}',
                      ),
                      if (collecte['commentaire'] != null &&
                          collecte['commentaire'].toString().isNotEmpty)
                        _buildRow(
                          Icons.comment,
                          'Commentaire : ${collecte['commentaire']}',
                        ),
                      if (collecte['ville'] != null)
                        _buildRow(
                          Icons.location_city,
                          'Ville : ${collecte['ville']}',
                        ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  String _formatTypes(dynamic types) {
    if (types is List) {
      return types.join(', ');
    }
    return types?.toString() ?? 'N/A';
  }
}
