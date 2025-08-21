// // ignore_for_file: avoid_print

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:recycleapp/models/entreprise_abonnement_model.dart';
// import 'package:recycleapp/widgets/card/bundle_card.dart';
// import 'package:go_router/go_router.dart';

// class SubscriptionCard extends StatefulWidget {
//   final String username;

//   const SubscriptionCard({super.key, required this.username});

//   @override
//   State<SubscriptionCard> createState() => _SubscriptionCardState();
// }

// class _SubscriptionCardState extends State<SubscriptionCard> {
//   String? abonnementType;
//   int? joursRestants;
//   String? imagePath;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadSubscription();
//   }

//   Future<void> _loadSubscription() async {
//     try {
//       final query =
//           await FirebaseFirestore.instance
//               .collection('subscriptions')
//               .where('userName', isEqualTo: widget.username)
//               .orderBy('dateDebut', descending: true)
//               .limit(1)
//               .get();

//       if (query.docs.isNotEmpty) {
//         final data = query.docs.first.data();
//         final dateFin = (data['dateFin'] as Timestamp).toDate();
//         final remaining = dateFin.difference(DateTime.now()).inDays;

//         setState(() {
//           abonnementType = data['typeAbonnement'];
//           joursRestants = remaining > 0 ? remaining : 0;
//           imagePath = secome.logoUrl;
//           isLoading = false;
//         });
//       } else {
//         setState(() => isLoading = false);
//       }
//     } catch (e) {
//       print("Erreur chargement abonnement: $e");
//       setState(() => isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }

//     final bool hasSubscription =
//         abonnementType != null && joursRestants != null;

//     return PromoCard(
//       imagePath: hasSubscription ? imagePath : null,
//       type: hasSubscription ? abonnementType : null,
//       remainingDays: hasSubscription ? joursRestants : null,
//       horaire: hasSubscription ? secome.ramassagesParSemaine.toString() : null,
//       onButtonPressed: () => context.push('/my-subscription'),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/widgets/card/bundle_card.dart';
import 'package:go_router/go_router.dart';

class SubscriptionCard extends StatelessWidget {
  final String username;

  const SubscriptionCard({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream:
          FirebaseFirestore.instance
              .collection('subscriptions')
              .where('userName', isEqualTo: username)
              .orderBy('dateDebut', descending: true)
              .limit(1)
              .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          // Aucun abonnement trouvé
          return PromoCard(
            imagePath: null,
            type: null,
            remainingDays: null,
            horaire: null,
            onButtonPressed: () => context.push('/my-subscription'),
          );
        }

        final doc = snapshot.data!.docs.first;
        final data = doc.data() as Map<String, dynamic>;

        final DateTime dateFin = (data['dateFin'] as Timestamp).toDate();
        final int joursRestants = dateFin.difference(DateTime.now()).inDays;
        final String typeAbonnement = data['typeAbonnement'];

        return PromoCard(
          imagePath: secome.logoUrl,
          type: typeAbonnement,
          remainingDays: joursRestants > 0 ? joursRestants : 0,
          horaire: secome.ramassagesParSemaine.toString(),
          onButtonPressed: () => context.push('/my-subscription'),
        );
      },
    );
  }
}
