import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location {
  final String name;
  final String description;
  final String imageUrl;
  final LatLng latLng;
  final String distance;
  final String openTime;
  final String price;

  Location({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.latLng,
    required this.distance,
    required this.openTime,
    required this.price,
  });

  factory Location.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    // Lire "position": { lat: ..., lng: ... }
    final position = data['position'];
    if (position == null || position['lat'] == null || position['lng'] == null) {
      throw Exception("Missing position in document ${doc.id}");
    }

    final lat = (position['lat'] as num).toDouble();
    final lng = (position['lng'] as num).toDouble();

    return Location(
      name: data['name'] ?? 'Sans nom',
      description: data['details'] ?? 'Aucune description',
      imageUrl: 'assets/images/default.jpg', // modifiable si tu ajoutes une image dans Firestore
      latLng: LatLng(lat, lng),
      distance: 'Inconnue', // sera calculé plus tard
      openTime: data['openTime'] ??'Inconnue', // peut être ajouté dans Firestore plus tard
      price: data['price'] ??'Gratuit', // valeur par défaut
    );
  }

  Location copyWith({String? distance}) {
    return Location(
      name: name,
      description: description,
      imageUrl: imageUrl,
      latLng: latLng,
      distance: distance ?? this.distance,
      openTime: openTime,
      price: price,
    );
  }
}
