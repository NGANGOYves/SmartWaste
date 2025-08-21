class UserModel {
  final String uid;
  final String nom;
  final String email;
  final String telephone;
  final String adresse;
  final String photoProfil;
  final String? ecoPoints;

  UserModel({
    required this.uid,
    required this.nom,
    required this.email,
    required this.telephone,
    required this.adresse,
    required this.photoProfil,
    this.ecoPoints,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      nom: map['nom'] ?? '',
      email: map['email'] ?? '',
      telephone: map['telephone'] ?? '',
      adresse: map['adresse'] ?? '',
      photoProfil: map['photoProfil'] ?? '',
      ecoPoints: map['ecoPoints'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'email': email,
      'telephone': telephone,
      'adresse': adresse,
      'photoProfil': photoProfil,
      'ecoPoint': ecoPoints,
    };
  }
}
