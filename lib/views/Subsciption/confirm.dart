import 'package:flutter/material.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/views/Subsciption/payement_view.dart';

class Confirm extends StatelessWidget {
  final EntrepriseAbonnement entreprise;
  final OffreAbonnement offre;
  final bool autorenew;

  const Confirm({
    super.key,
    required this.entreprise,
    required this.offre,
    required this.autorenew,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Confirmation d'abonnement"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 70),
            const SizedBox(height: 10),
            const Text(
              "Prêt à rejoindre une PME écoresponsable ?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),

            // Résumé entreprise + offre
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    entreprise.nomEntreprise,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    offre.titre,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    offre.prixDisplay,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),

            const Text(
              'Détails de l\'abonnement :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            DetailTile(
              icon: Icons.recycling,
              label: 'Ramassages / semaine',
              value: '${entreprise.ramassagesParSemaine}',
            ),
            DetailTile(
              icon: Icons.description,
              label: 'Description',
              value: entreprise.description,
            ),
            DetailTile(
              icon: Icons.money,
              label: 'Formule choisie',
              value: offre.titre,
            ),

            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder:
                        (_) => PaymentPage(
                          amount: offre.prixDisplay,
                          formule: offre.titre,
                          autorenew: autorenew,
                        ),
                  ),
                );
              },
              icon: const Icon(Icons.payment),
              label: Text('Souscrire pour ${offre.prixDisplay}'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                "Vous pouvez annuler à tout moment.",
                style: TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(value),
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
    );
  }
}
