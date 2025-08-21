class SpecialPickupRequest {
  final String id;
  final String user;
  final String userEmail;
  final String telephone;
  final List<String> types;
  final String commentaire;
  final String date;
  final String adresse;
  final String ville;
  final String status;
  final DateTime createdAt;

  SpecialPickupRequest({
    required this.id,
    required this.user,
    required this.userEmail,
    required this.telephone,
    required this.types,
    required this.commentaire,
    required this.date,
    required this.adresse,
    required this.ville,
    required this.status,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': user,
      'userEmail': userEmail,
      'telephone': telephone,
      'types': types,
      'commentaire': commentaire,
      'date': date,
      'adresse': adresse,
      'ville': ville,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SpecialPickupRequest.fromMap(Map<String, dynamic> map) {
    return SpecialPickupRequest(
      id: map['id'],
      user: map['user'],
      userEmail: map['userEmail'],
      telephone: map['telephone'],
      types: List<String>.from(map['types']),
      commentaire: map['commentaire'],
      date: map['date'],
      adresse: map['adresse'],
      ville: map['ville'],
      status: map['status'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
