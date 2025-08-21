// import 'package:flutter/material.dart';
// import 'package:loader_overlay/loader_overlay.dart';
// import 'package:recycleapp/models/abonnement_model.dart';
// import 'package:recycleapp/views/Subsciption/subscription_detail.dart';

// class SubscriptionCard extends StatelessWidget {
//   final Abonnement abonnement;

//   const SubscriptionCard({super.key, required this.abonnement});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 4,
//       color: Colors.white,
//       child: InkWell(
//         borderRadius: BorderRadius.circular(16),
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => SubscriptionDetailView(abonnement: abonnement),
//             ),
//           );
//         },
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.asset(
//                   abonnement.imageUrl,
//                   height: 150,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               const SizedBox(height: 12),
//               Text(
//                 abonnement.nomPME,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 abonnement.description,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 14, color: Colors.black87),
//               ),
//               const SizedBox(height: 12),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Row(
//                     children: [
//                       const Icon(
//                         Icons.monetization_on,
//                         color: Colors.green,
//                         size: 20,
//                       ),
//                       const SizedBox(width: 4),
//                       Text(
//                         '${abonnement.prixMensuel.toStringAsFixed(0)} FCFA/mois',
//                         style: const TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () async {
//                       context.loaderOverlay.show();
//                       await Future.delayed(const Duration(seconds: 1));
//                       if (context.mounted) {
//                         context.loaderOverlay.hide();
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder:
//                                 (_) => SubscriptionDetailView(
//                                   abonnement: abonnement,
//                                 ),
//                           ),
//                         );
//                       }
//                     },
//                     icon: const Icon(Icons.subscriptions),
//                     label: const Text('Voir'),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.green,
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size(100, 40), // Width x Height
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/views/Subsciption/subscription_detail.dart';

class EntrepriseSubscriptionCard extends StatelessWidget {
  final EntrepriseAbonnement entreprise;

  const EntrepriseSubscriptionCard({super.key, required this.entreprise});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SubscriptionDetailView(entreprise: entreprise),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Affiche le logo ou une image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  entreprise.logoUrl,
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 12),

              // Nom de l'entreprise
              Text(
                entreprise.nomEntreprise,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 6),

              // Description courte
              Text(
                entreprise.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              // Aperçu des offres (max 2)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                    entreprise.offres.take(2).map((offre) {
                      return Row(
                        children: [
                          const Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              "${offre.titre} - ${offre.prixDisplay}",
                              style: const TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
              ),

              const SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${entreprise.ramassagesParSemaine} ramassages/sem.",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      context.loaderOverlay.show();
                      await Future.delayed(const Duration(milliseconds: 800));
                      if (context.mounted) {
                        context.loaderOverlay.hide();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => SubscriptionDetailView(
                                  entreprise: entreprise,
                                ),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.subscriptions),
                    label: const Text('Voir'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(100, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
