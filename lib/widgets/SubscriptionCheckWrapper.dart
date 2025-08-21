// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recycleapp/views/signal/a_domicile/signal_domicile.dart';
import 'package:recycleapp/widgets/NotSubscribedPage.dart';

class SubscriptionCheckWrapper extends StatelessWidget {
  const SubscriptionCheckWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<UserProvider>().user;
    final username = user?.nom.trim();

    if (username == null || username.isEmpty) {
      return const NotSubscribedPage();
    }

    return FutureBuilder<QuerySnapshot>(
      future:
          FirebaseFirestore.instance
              .collection('subscriptions')
              .where('userName', isEqualTo: username)
              .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const NotSubscribedPage();
        }

        // Subscription exists
        return const SpecialPickupFormPage();
      },
    );
  }
}
