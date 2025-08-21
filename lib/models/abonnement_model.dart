class Abonnement {
  final String id;
  final String nomPME;
  final String imageUrl; // Logo ou image de présentation de la PME
  final String description;
  final double prixMensuel; // en FCFA
  final List<String> zonesDesservies; // quartiers ou arrondissements
  final List<String> joursDePassage; // e.g. ["Lundi", "Jeudi"]
  final String heureDePassage; // e.g. "08:00 - 12:00"
  final bool collecteADomicile; // true si collecte à domicile
  final bool triSelectifInclus;
  final bool serviceUrgence; // nettoyage d'urgence
  final String contactPME; // téléphone ou email
  final DateTime dateDebutDisponibilite;
  final bool actif;

  Abonnement({
    required this.id,
    required this.nomPME,
    required this.imageUrl,
    required this.description,
    required this.prixMensuel,
    required this.zonesDesservies,
    required this.joursDePassage,
    required this.heureDePassage,
    required this.collecteADomicile,
    required this.triSelectifInclus,
    required this.serviceUrgence,
    required this.contactPME,
    required this.dateDebutDisponibilite,
    required this.actif,
  });

  factory Abonnement.fromMap(Map<String, dynamic> map) {
    return Abonnement(
      id: map['id'],
      nomPME: map['nomPME'],
      imageUrl: map['imageUrl'],
      description: map['description'],
      prixMensuel: map['prixMensuel'].toDouble(),
      zonesDesservies: List<String>.from(map['zonesDesservies']),
      joursDePassage: List<String>.from(map['joursDePassage']),
      heureDePassage: map['heureDePassage'],
      collecteADomicile: map['collecteADomicile'],
      triSelectifInclus: map['triSelectifInclus'],
      serviceUrgence: map['serviceUrgence'],
      contactPME: map['contactPME'],
      dateDebutDisponibilite: DateTime.parse(map['dateDebutDisponibilite']),
      actif: map['actif'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nomPME': nomPME,
      'imageUrl': imageUrl,
      'description': description,
      'prixMensuel': prixMensuel,
      'zonesDesservies': zonesDesservies,
      'joursDePassage': joursDePassage,
      'heureDePassage': heureDePassage,
      'collecteADomicile': collecteADomicile,
      'triSelectifInclus': triSelectifInclus,
      'serviceUrgence': serviceUrgence,
      'contactPME': contactPME,
      'dateDebutDisponibilite': dateDebutDisponibilite.toIso8601String(),
      'actif': actif,
    };
  }
}
