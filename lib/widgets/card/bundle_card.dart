import 'package:flutter/material.dart';

class PromoCard extends StatelessWidget {
  final String? imagePath; // Nullable
  final String? horaire;
  final String? type;
  final int? remainingDays;
  final VoidCallback? onButtonPressed; // callback obligatoire

  const PromoCard({
    super.key,
    this.imagePath,
    this.horaire,
    this.type,
    this.remainingDays,
    this.onButtonPressed,
  });

  bool get hasNoBundle =>
      horaire == null && type == null && remainingDays == null;

  @override
  Widget build(BuildContext context) {
    final String bannerImage = imagePath ?? 'assets/image/start.png';

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Column(
        children: [
          // Banner Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.asset(
              bannerImage,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Info Section
          Padding(
            padding: const EdgeInsets.all(12),
            child:
                hasNoBundle
                    ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.info_outline,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Aucun abonnement actif pour le moment.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: onButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                          ),
                          child: const Text("Mon Abonnement"),
                        ),
                      ],
                    )
                    : Column(
                      children: [
                        if (horaire != null)
                          if (horaire != null) const SizedBox(height: 6),

                        if (type != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.business,
                                size: 18,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                'Type Formule : ${type!}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),

                        if (type != null) const SizedBox(height: 12),

                        if (remainingDays != null)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "$remainingDays jour(s) restants",
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: onButtonPressed,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                ),
                                child: const Text(
                                  "voir plus",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
          ),
        ],
      ),
    );
  }
}
