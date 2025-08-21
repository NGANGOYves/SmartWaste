// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:recycleapp/models/subscription_model.dart';
// import 'package:recycleapp/widgets/card/subscription_card.dart';
// // import 'package:recycleapp/widgets/dialogs/dialog.dart';

// class SubscriptionListView extends StatelessWidget {
//   SubscriptionListView({super.key});

//   final List<Subscription> subscriptions = [
//     Subscription(
//       title: 'Nom de la PME',
//       subtitle: 'Bisa menukarkan RuntahPoints menjadi saldo Gopay',
//       imageUrl: 'assets/image/sub.png',
//       points: 10000,
//     ),
//     Subscription(
//       title: 'Saldo Dana',
//       subtitle: 'Bisa menukarkan RuntahPoints menjadi saldo Dana',
//       imageUrl: 'assets/image/sub.png',
//       points: 10000,
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Abonnement'),
//         leading: IconButton(
//           onPressed: () => context.go("/home"),
//           icon: Icon(Icons.arrow_back),
//         ),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.all(16),
//         children:
//             subscriptions
//                 .map(
//                   (subscription) =>
//                       SubscriptionCard(subscription: subscription),
//                 )
//                 .toList(),
//       ),
//     );
//   }
// }

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/widgets/card/subscription_card.dart';

class SubscriptionListView extends StatelessWidget {
  const SubscriptionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Abonnements'),
          backgroundColor: Colors.green,
          leading: IconButton(
            onPressed: () => context.go("/home"),
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        body: Column(
          children: [EntrepriseSubscriptionCard(entreprise: secome)],
        ),
      ),
    );
  }
}
