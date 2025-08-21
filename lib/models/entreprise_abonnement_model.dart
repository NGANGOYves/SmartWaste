class EntrepriseAbonnement {
  final String nomEntreprise; // Ex: SECOME
  final String description; // Slogan ou description courte
  final String logoUrl; // Logo/image
  final List<OffreAbonnement> offres; // Les offres proposées
  final String contact1; // Numéro principal
  final String contact2; // Numéro secondaire
  final int ramassagesParSemaine;

  EntrepriseAbonnement({
    required this.nomEntreprise,
    required this.description,
    required this.logoUrl,
    required this.offres,
    required this.contact1,
    required this.contact2,
    this.ramassagesParSemaine = 2,
  });

  factory EntrepriseAbonnement.fromMap(Map<String, dynamic> map) {
    return EntrepriseAbonnement(
      nomEntreprise: map['nomEntreprise'] ?? '',
      description: map['description'] ?? '',
      logoUrl: map['logoUrl'] ?? '',
      offres:
          (map['offres'] as List<dynamic>)
              .map((o) => OffreAbonnement.fromMap(o))
              .toList(),
      contact1: map['contact1'] ?? '',
      contact2: map['contact2'] ?? '',
      ramassagesParSemaine: map['ramassagesParSemaine'] ?? 2,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nomEntreprise': nomEntreprise,
      'description': description,
      'logoUrl': logoUrl,
      'offres': offres.map((e) => e.toMap()).toList(),
      'contact1': contact1,
      'contact2': contact2,
      'ramassagesParSemaine': ramassagesParSemaine,
    };
  }
}

class OffreAbonnement {
  final String titre; // Ex: Boutique, Maison
  final String cible; // Ex: "Résidence privée"
  final int prixMin; // Prix minimal
  final int prixMax; // Prix max si variable

  OffreAbonnement({
    required this.titre,
    required this.cible,
    required this.prixMin,
    this.prixMax = 0,
  });

  factory OffreAbonnement.fromMap(Map<String, dynamic> map) {
    return OffreAbonnement(
      titre: map['titre'] ?? '',
      cible: map['cible'] ?? '',
      prixMin: map['prixMin'] ?? 0,
      prixMax: map['prixMax'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titre': titre,
      'cible': cible,
      'prixMin': prixMin,
      'prixMax': prixMax,
    };
  }

  String get prixDisplay {
    if (prixMax > 0 && prixMax != prixMin) {
      return "$prixMin FCFA - $prixMax FCFA";
    }
    return "$prixMin FCFA";
  }
}

final secome = EntrepriseAbonnement(
  nomEntreprise: "SECOME",
  description: "Avec Secome !! vide tes poubelles, ton quartier reste propre !",
  logoUrl: "assets/images/secome.png", // ou un lien réseau
  contact1: "677 736 345",
  contact2: "693 969 423",
  ramassagesParSemaine: 2,
  offres: [
    OffreAbonnement(
      titre: "Boutique",
      cible: "Petits commerces",
      prixMin: 3000,
    ),
    OffreAbonnement(
      titre: "Centre de santé",
      cible: "Hôpital, clinique",
      prixMin: 5000,
    ),
    OffreAbonnement(
      titre: "École primaire",
      cible: "Établissements de base",
      prixMin: 5000,
    ),
    OffreAbonnement(
      titre: "Collège",
      cible: "Enseignement secondaire",
      prixMin: 8000,
    ),
    OffreAbonnement(
      titre: "Université",
      cible: "Établissement supérieur",
      prixMin: 15000,
    ),
    OffreAbonnement(
      titre: "Maison",
      cible: "Résidence, domicile privé",
      prixMin: 5000,
      prixMax: 15000,
    ),
  ],
);
