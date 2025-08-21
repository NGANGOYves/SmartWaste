class Signalement {
  final String? nom;
  final String? email;
  final String? imagePath;
  final String? localisation;
  final String? informationsSupplementaires;
  final DateTime dateSignalement;
  final bool estAnonyme;

  Signalement({
    this.nom,
    this.email,
    this.imagePath,
    this.localisation,
    this.informationsSupplementaires,
    required this.dateSignalement,
    required this.estAnonyme,
  });

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
      'image': imagePath,
      'localisation': localisation,
      'details': informationsSupplementaires,
      'createdAt': dateSignalement.toIso8601String(),
      'estAnonyme': estAnonyme,
      'signale': true,
    };
  }
}
