// // ignore_for_file: file_names, avoid_print, use_build_context_synchronously

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:provider/provider.dart';
// import 'package:recycleapp/models/entreprise_abonnement_model.dart';
// import 'package:recycleapp/services/user_provider.dart';

// class MySubscriptionPage extends StatefulWidget {
//   const MySubscriptionPage({super.key});

//   @override
//   State<MySubscriptionPage> createState() => _MySubscriptionPageState();
// }

// class _MySubscriptionPageState extends State<MySubscriptionPage> {
//   Map<String, dynamic>? abonnement;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadAbonnement();
//   }

//   Future<void> _loadAbonnement() async {
//     // final user = FirebaseAuth.instance.currentUser;
//     final user = context.read<UserProvider>().user;
//     if (user == null) {
//       setState(() => isLoading = false);
//       return;
//     }

//     try {
//       final snapshot =
//           await FirebaseFirestore.instance
//               .collection('subscriptions')
//               .where('userName', isEqualTo: user.nom)
//               .orderBy('dateDebut', descending: true)
//               .limit(1)
//               .get();

//       if (snapshot.docs.isNotEmpty) {
//         final data = snapshot.docs.first.data();

//         final Timestamp dateFinTs = data['dateFin'];
//         final DateTime dateFin = dateFinTs.toDate();
//         final DateTime today = DateTime.now();

//         final int joursRestants = dateFin.difference(today).inDays;

//         // add 'joursRestants' to the abonnement map
//         data['joursRestants'] = joursRestants >= 0 ? joursRestants : 0;

//         setState(() {
//           abonnement = data;
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

//   Future<void> _cancelSubscription() async {
//     final user = context.read<UserProvider>().user;
//     if (user == null) return;

//     try {
//       final snapshot =
//           await FirebaseFirestore.instance
//               .collection('subscriptions')
//               .where('userName', isEqualTo: user.nom)
//               .orderBy('dateDebut', descending: true)
//               .limit(1)
//               .get();

//       if (snapshot.docs.isNotEmpty) {
//         await snapshot.docs.first.reference.delete();

//         setState(() {
//           abonnement = null;
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Souscription annulée avec succès.")),
//         );
//         context.go('/home');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Aucune souscription à annuler.")),
//         );
//       }
//     } catch (e) {
//       print("Erreur suppression abonnement: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Erreur lors de l'annulation.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Theme.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Mon Abonnement"),
//         backgroundColor: Colors.green,
//         foregroundColor: Colors.white,
//       ),
//       body:
//           isLoading
//               ? const Center(child: CircularProgressIndicator())
//               : abonnement == null
//               ? const Center(child: Text("Aucun abonnement trouvé."))
//               : SingleChildScrollView(
//                 padding: const EdgeInsets.all(16),
//                 child: Column(
//                   children: [
//                     // Image Banner
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(16),
//                       child: Image.asset(
//                         secome.logoUrl,
//                         height: 150,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Type
//                     ListTile(
//                       leading: const Icon(
//                         Icons.subscriptions,
//                         color: Colors.green,
//                       ),
//                       title: const Text("Type d'abonnement"),
//                       subtitle: Text(abonnement!['typeAbonnement']),
//                     ),

//                     // PME
//                     ListTile(
//                       leading: const Icon(Icons.business, color: Colors.orange),
//                       title: const Text("Entreprise"),
//                       subtitle: Text(abonnement!['pmeName']),
//                     ),

//                     // Description
//                     ListTile(
//                       leading: const Icon(
//                         Icons.description,
//                         color: Colors.blue,
//                       ),
//                       title: const Text("Description"),
//                       subtitle: Text(abonnement!['description']),
//                     ),

//                     // Dates
//                     ListTile(
//                       leading: const Icon(
//                         Icons.date_range,
//                         color: Colors.purple,
//                       ),
//                       title: const Text("Durée"),
//                       subtitle: Text(
//                         "Du ${_formatDate(abonnement!['dateDebut'])} au ${_formatDate(abonnement!['dateFin'])}",
//                       ),
//                     ),

//                     // Jours restants
//                     ListTile(
//                       leading: const Icon(Icons.timer, color: Colors.teal),
//                       title: const Text("Jours restants"),
//                       subtitle: Text("${abonnement!['joursRestants']} jours"),
//                     ),
//                     ListTile(
//                       leading: const Icon(Icons.repeat_one, color: Colors.teal),
//                       title: const Text("Renouvelement Auto"),
//                       subtitle: Text(
//                         abonnement!['autorenew'] == true ? 'Oui' : 'Non',
//                       ),
//                     ),

//                     const SizedBox(height: 20),
//                     ElevatedButton.icon(
//                       onPressed: _cancelSubscription,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.red,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 12,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       icon: const Icon(Icons.cancel),
//                       label: const Text("Annuler la souscription"),
//                     ),
//                   ],
//                 ),
//               ),
//     );
//   }

//   String _formatDate(Timestamp ts) {
//     final date = ts.toDate();
//     return "${date.day}/${date.month}/${date.year}";
//   }
// }

// ignore_for_file: file_names, avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/services/user_provider.dart';

class MySubscriptionPage extends StatefulWidget {
  const MySubscriptionPage({super.key});

  @override
  State<MySubscriptionPage> createState() => _MySubscriptionPageState();
}

class _MySubscriptionPageState extends State<MySubscriptionPage> {
  Map<String, dynamic>? abonnement;
  bool isLoading = true;
  bool _isDeleting = false; // 👈 Ajouté

  @override
  void initState() {
    super.initState();
    _loadAbonnement();
  }

  Future<void> _loadAbonnement() async {
    final user = context.read<UserProvider>().user;
    if (user == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('userName', isEqualTo: user.nom)
              .orderBy('dateDebut', descending: true)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        final data = snapshot.docs.first.data();
        final Timestamp dateFinTs = data['dateFin'];
        final DateTime dateFin = dateFinTs.toDate();
        final DateTime today = DateTime.now();
        final int joursRestants = dateFin.difference(today).inDays;
        data['joursRestants'] = joursRestants >= 0 ? joursRestants : 0;

        setState(() {
          abonnement = data;
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Erreur chargement abonnement: $e");
      setState(() => isLoading = false);
    }
  }

  Future<void> _cancelSubscription() async {
    final user = context.read<UserProvider>().user;
    if (user == null) return;

    setState(() {
      _isDeleting = true; // 👈 Commence le chargement
    });

    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('userName', isEqualTo: user.nom)
              .orderBy('dateDebut', descending: true)
              .limit(1)
              .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();

        setState(() {
          abonnement = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Souscription annulée avec succès.")),
        );

        context.go('/home'); // 👈 Navigation seulement après suppression
      } else {
        setState(() {
          _isDeleting = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Aucune souscription à annuler.")),
        );
      }
    } catch (e) {
      print("Erreur suppression abonnement: $e");

      setState(() {
        _isDeleting = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Erreur lors de l'annulation.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon Abonnement"),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : abonnement == null
              ? const Center(child: Text("Aucun abonnement trouvé."))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        secome.logoUrl,
                        height: 150,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListTile(
                      leading: const Icon(
                        Icons.subscriptions,
                        color: Colors.green,
                      ),
                      title: const Text("Type d'abonnement"),
                      subtitle: Text(abonnement!['typeAbonnement']),
                    ),
                    ListTile(
                      leading: const Icon(Icons.business, color: Colors.orange),
                      title: const Text("Entreprise"),
                      subtitle: Text(abonnement!['pmeName']),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.description,
                        color: Colors.blue,
                      ),
                      title: const Text("Description"),
                      subtitle: Text(abonnement!['description']),
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.date_range,
                        color: Colors.purple,
                      ),
                      title: const Text("Durée"),
                      subtitle: Text(
                        "Du ${_formatDate(abonnement!['dateDebut'])} au ${_formatDate(abonnement!['dateFin'])}",
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.timer, color: Colors.teal),
                      title: const Text("Jours restants"),
                      subtitle: Text("${abonnement!['joursRestants']} jours"),
                    ),
                    ListTile(
                      leading: const Icon(Icons.repeat_one, color: Colors.teal),
                      title: const Text("Renouvelement Auto"),
                      subtitle: Text(
                        abonnement!['autorenew'] == true ? 'Oui' : 'Non',
                      ),
                    ),
                    const SizedBox(height: 20),
                    _isDeleting
                        ? const CircularProgressIndicator() // 👈 Loader pendant suppression
                        : ElevatedButton.icon(
                          onPressed: _cancelSubscription,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          icon: const Icon(Icons.cancel),
                          label: const Text("Annuler la souscription"),
                        ),
                  ],
                ),
              ),
    );
  }

  String _formatDate(Timestamp ts) {
    final date = ts.toDate();
    return "${date.day}/${date.month}/${date.year}";
  }
}
