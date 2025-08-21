import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/views/Subsciption/confirm.dart';
import 'package:recycleapp/widgets/buttons/custom_button.dart';

class SubscriptionDetailView extends StatefulWidget {
  final EntrepriseAbonnement entreprise;
  const SubscriptionDetailView({super.key, required this.entreprise});

  @override
  State<SubscriptionDetailView> createState() => _SubscriptionDetailViewState();
}

class _SubscriptionDetailViewState extends State<SubscriptionDetailView> {
  final TextEditingController phoneController = TextEditingController();
  OffreAbonnement? selectedOffer;
  bool _isAutoRenew = false;

  @override
  void initState() {
    super.initState();
    // Choisir par défaut la première offre s'il y en a
    if (widget.entreprise.offres.isNotEmpty) {
      selectedOffer = widget.entreprise.offres.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text('Détails Abonnement'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.entreprise.logoUrl,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.entreprise.nomEntreprise,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.entreprise.description,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const Divider(height: 30),
            Row(
              children: [
                const Icon(Icons.delete_outline, color: Colors.green),
                const SizedBox(width: 8),
                Text(
                  '${widget.entreprise.ramassagesParSemaine} ramassages / semaine',
                ),
              ],
            ),
            const SizedBox(height: 16),

            const Text(
              'Choisissez votre formule :',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<OffreAbonnement>(
              value: selectedOffer,
              items:
                  widget.entreprise.offres.map((offre) {
                    return DropdownMenuItem(
                      value: offre,
                      child: Text('${offre.titre} - ${offre.prixDisplay}'),
                    );
                  }).toList(),
              onChanged: (newVal) {
                setState(() {
                  selectedOffer = newVal;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(
                labelText: 'Numéro de téléphone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 12),

            CheckboxListTile(
              value: _isAutoRenew,
              onChanged: (val) {
                setState(() {
                  _isAutoRenew = val ?? false;
                });
              },
              title: const Text('Renouvellement automatique'),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
            const SizedBox(height: 16),

            CustomButton(
              text:
                  selectedOffer != null
                      ? 'Souscrire pour ${selectedOffer!.prixDisplay}'
                      : 'Choisir une formule',
              onPressed:
                  selectedOffer == null
                      ? null
                      : () async {
                        context.loaderOverlay.show();
                        await Future.delayed(const Duration(seconds: 1));
                        if (context.mounted) {
                          context.loaderOverlay.hide();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) => Confirm(
                                    entreprise: widget.entreprise,
                                    offre: selectedOffer!,
                                    autorenew: _isAutoRenew,
                                  ),
                            ),
                          );
                        }
                      },
            ),
          ],
        ),
      ),
    );
  }
}
