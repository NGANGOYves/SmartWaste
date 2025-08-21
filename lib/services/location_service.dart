// import '../models/location_model.dart';

// class LocationService {
//   // Liste de lieux simulés
//   static List<LocationModel> getMockLocations() {
//     return [
//       LocationModel(
//         id: '1',
//         title: 'Recyclage Bonapriso',
//         description: 'Centre de tri pour plastiques, papiers et cartons',
//         imageUrl: 'https://via.placeholder.com/150',
//         latitude: 4.0515,
//         longitude: 9.7671,
//         category: 'recyclage',
//         rating: 4.5,
//       ),
//       LocationModel(
//         id: '2',
//         title: 'Compost Yaoundé',
//         description: 'Station de compostage communautaire bio',
//         imageUrl: 'https://via.placeholder.com/150',
//         latitude: 3.857,
//         longitude: 11.502,
//         category: 'compost',
//         rating: 4.0,
//       ),
//       LocationModel(
//         id: '3',
//         title: 'Centre de Verre Douala',
//         description: 'Dépôt pour verres et bouteilles usagées',
//         imageUrl: 'https://via.placeholder.com/150',
//         latitude: 4.0552,
//         longitude: 9.7812,
//         category: 'verre',
//         rating: 3.8,
//       ),
//     ];
//   }

//   // Récupérer un lieu par ID
//   static LocationModel? getLocationById(String id) {
//     return getMockLocations().firstWhere((loc) => loc.id == id, orElse: () => null as LocationModel);
//   }

//   // Filtrer par catégorie
//   static List<LocationModel> filterByCategory(String category) {
//     return getMockLocations()
//         .where((loc) => loc.category.toLowerCase() == category.toLowerCase())
//         .toList();
//   }
// }
