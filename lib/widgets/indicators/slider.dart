// import 'package:flutter/material.dart';

// class FeatureSlider extends StatefulWidget {
//   const FeatureSlider({super.key});

//   @override
//   State<FeatureSlider> createState() => _FeatureSliderState();
// }

// class _FeatureSliderState extends State<FeatureSlider> {
//   final PageController _controller = PageController();
//   int _currentPage = 0;

//   final List<Map<String, dynamic>> features = [
//     {
//       'title': 'Collecte à Domicile',
//       'description': 'Programmez une collecte rapide à votre domicile.',
//       'image': 'assets/image/collecte.png',
//     },
//     {
//       'title': 'Fidélité Récompensée',
//       'description': 'Gagnez des points à chaque collecte et échangez-les.',
//       'image': 'assets/image/recompense.png',
//     },
//     {
//       'title': 'Signalement Simplifié',
//       'description': 'Signalez un point de collecte directement via l\'app.',
//       'image': 'assets/image/signaler.png',
//     },
//     {
//       'title': 'Tichlof',
//       'isEnterprise': true,
//       'nomPME': 'THYCHLOF SARL',
//       'description':
//           'Entreprise de propreté urbaine, collecte hebdomadaire, tri sélectif et enlèvement à domicile à Yaoundé 3.',
//       'image': 'assets/images/tychlof.png',
//       'planningZones': [
//         {
//           'zone': 'Bloc d’Administratif',
//           'jour': 'Lundi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Axe École Normal', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Axe du SED', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Axe Polytech', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
//         {
//           'zone': 'Axe Central Melen + Bretelles',
//           'jour': 'Lundi',
//           'heure': '07:00 - 12:00',
//         },
//         {
//           'zone': 'Mur CETIC Ngoa Ekelle',
//           'jour': 'Lundi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Brigade Melen', 'jour': null, 'heure': '07:00 - 16:00'},
//         {
//           'zone': 'Axe Assemblée Nationale',
//           'jour': null,
//           'heure': '07:00 - 16:00',
//         },
//         {
//           'zone': 'Route Central Olezoua + Ambassade de France',
//           'jour': null,
//           'heure': '07:00 - 16:00',
//         },
//         {'zone': 'Quartier Général', 'jour': null, 'heure': '07:00 - 16:00'},
//         {'zone': 'Camp Gelain', 'jour': null, 'heure': '07:00 - 16:00'},
//         {
//           'zone': 'Cité des Nations – CETIC Nko Ekelle',
//           'jour': null,
//           'heure': '07:00 - 16:00',
//         },
//         {'zone': 'Dakar', 'jour': null, 'heure': '07:00 - 16:00'},
//         {'zone': 'Montée Ponias', 'jour': null, 'heure': '07:00 - 16:00'},
//         {'zone': 'Efoulan Lycée', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Efoulan École', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
//         {
//           'zone': 'Bretelle Mairie d’Efoulan',
//           'jour': 'Mardi',
//           'heure': '07:00 - 12:00',
//         },
//         {
//           'zone': 'Bretelle chez le Super Maire Efoulan',
//           'jour': 'Mardi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Efoulan Pont', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Don Japonais', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
//         {
//           'zone': 'Intérieur Terre Rouge',
//           'jour': 'Mardi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Olimpic', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
//         {'zone': 'Efoulan Lac', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
//         {
//           'zone': 'Shell Siméyong',
//           'jour': 'Mercredi',
//           'heure': '13:00 - 16:00',
//         },
//         {
//           'zone': 'Rond Point Vogt',
//           'jour': 'Mercredi',
//           'heure': '13:00 - 16:00',
//         },
//         {'zone': 'Schalon', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
//         {
//           'zone': 'Montée Chapelle Obili',
//           'jour': 'Mercredi',
//           'heure': '13:00 - 16:00',
//         },
//         {'zone': 'Face Sonel Nsam', 'jour': 'Jeudi', 'heure': '07:00 - 12:00'},
//         {
//           'zone': 'Porte à Porte Face Sofaving',
//           'jour': 'Jeudi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Dépôt Guinness', 'jour': 'Jeudi', 'heure': '07:00 - 12:00'},
//         {
//           'zone': 'Face Ola Barrière',
//           'jour': 'Jeudi',
//           'heure': '07:00 - 12:00',
//         },
//         {
//           'zone': 'Mur Sénateur Mama',
//           'jour': 'Jeudi',
//           'heure': '07:00 - 12:00',
//         },
//         {
//           'zone': 'Après Santa Lucia',
//           'jour': 'Jeudi',
//           'heure': '07:00 - 12:00',
//         },
//         {'zone': 'Porte à Porte', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
//         {
//           'zone': 'Bretelle Afanoyoa',
//           'jour': 'Vendredi',
//           'heure': '13:00 - 16:00',
//         },
//         {
//           'zone': 'Bretelle Sainte Mary',
//           'jour': 'Vendredi',
//           'heure': '13:00 - 16:00',
//         },
//         {'zone': 'Obam Ongola', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
//         {'zone': 'Nsam Escal', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
//         {'zone': 'Colombia', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Axe Obobogo', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Rail Obobogo', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Axe Damas', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
//         {'zone': 'Terre Rouge', 'jour': 'Samedi', 'heure': '13:00 - 16:00'},
//         {'zone': 'Victor Hugo', 'jour': 'Samedi', 'heure': '13:00 - 16:00'},
//       ], // truncated for brevity
//       'collecteADomicile': true,
//       'triSelectifInclus': true,
//       'serviceUrgence': false,
//       'contactPME':
//           'Téléphone : (237) 693 366 871\nEmail : thychlof@gmail.com\nBP: 658 Yaoundé',
//     },
//   ];

//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(const Duration(seconds: 2), autoSlide);
//   }

//   void autoSlide() {
//     if (_controller.hasClients) {
//       _currentPage = (_currentPage + 1) % features.length;
//       _controller.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 500),
//         curve: Curves.easeInOut,
//       );
//       Future.delayed(const Duration(seconds: 3), autoSlide);
//     }
//   }

//   void _showFeatureDetail(Map<String, dynamic> feature) {
//     if (feature['isEnterprise'] == true) {
//       _showEnterpriseDetail(feature);
//     } else {
//       _showRegularFeatureDetail(feature);
//     }
//   }

//   void _showRegularFeatureDetail(Map<String, dynamic> feature) {
//     final height = MediaQuery.of(context).size.height * 0.7;
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         return SizedBox(
//           height: height,
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//                 child: Image.asset(
//                   feature['image'],
//                   width: double.infinity,
//                   height: height * 0.4,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         feature['title'],
//                         style: const TextStyle(
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Text(
//                             feature['description'],
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 12),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             fixedSize: const Size(150, 50),
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                           child: const Text("Fermer"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   void _showEnterpriseDetail(Map<String, dynamic> data) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (context) {
//         final height = MediaQuery.of(context).size.height * 0.85;
//         final List zones = data['planningZones'];

//         return SizedBox(
//           height: height,
//           child: Column(
//             children: [
//               ClipRRect(
//                 borderRadius: const BorderRadius.vertical(
//                   top: Radius.circular(20),
//                 ),
//                 child: Image.asset(
//                   data['image'],
//                   width: double.infinity,
//                   height: height * 0.3,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         data['nomPME'],
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF28B446),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         data['description'],
//                         style: const TextStyle(fontSize: 15),
//                       ),
//                       const SizedBox(height: 12),
//                       Row(
//                         children: [
//                           if (data['collecteADomicile'])
//                             _buildTag("Collecte à domicile"),
//                           if (data['triSelectifInclus'])
//                             _buildTag("Tri sélectif"),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         "Planning de passage",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           child: Table(
//                             border: TableBorder.all(
//                               color: Colors.green.shade100,
//                             ),
//                             columnWidths: const {
//                               0: FlexColumnWidth(2),
//                               1: FlexColumnWidth(1),
//                               2: FlexColumnWidth(1),
//                             },
//                             children: [
//                               const TableRow(
//                                 decoration: BoxDecoration(
//                                   color: Color(0xFFE8F5E9),
//                                 ),
//                                 children: [
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Zone',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Jour',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Heure',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               ...zones.map((zone) {
//                                 return TableRow(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(zone['zone']),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(zone['jour'] ?? 'Variable'),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(zone['heure']),
//                                     ),
//                                   ],
//                                 );
//                               }).toList(),
//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       const Text(
//                         "Contact",
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         data['contactPME'],
//                         style: TextStyle(color: Colors.grey[800]),
//                       ),
//                       const SizedBox(height: 16),
//                       Align(
//                         alignment: Alignment.bottomRight,
//                         child: ElevatedButton(
//                           onPressed: () => Navigator.pop(context),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             foregroundColor: Colors.white,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                             fixedSize: const Size(150, 50),
//                           ),
//                           child: const Text("Fermer"),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTag(String label) {
//     return Container(
//       margin: const EdgeInsets.only(right: 8),
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: Colors.green.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         label,
//         style: const TextStyle(
//           color: Color(0xFF28B446),
//           fontWeight: FontWeight.w500,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 140,
//       child: PageView.builder(
//         controller: _controller,
//         itemCount: features.length,
//         itemBuilder: (context, index) {
//           final feature = features[index];
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(16),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.green.withOpacity(0.1),
//                     blurRadius: 8,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//                 border: Border.all(color: Colors.green.shade100),
//               ),
//               padding: const EdgeInsets.all(8),
//               child: Row(
//                 children: [
//                   ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.asset(
//                       feature['image'],
//                       height: 100,
//                       width: 60,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           feature['title'],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade800,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Expanded(
//                           child: Text(
//                             feature['description'] ?? '',
//                             style: TextStyle(
//                               fontSize: 14,
//                               color: Colors.grey.shade800,
//                             ),
//                           ),
//                         ),
//                         Align(
//                           alignment: Alignment.bottomRight,
//                           child: GestureDetector(
//                             onTap: () => _showFeatureDetail(feature),
//                             child: Text(
//                               "En savoir plus",
//                               style: TextStyle(
//                                 color: Colors.green.shade800,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class FeatureSlider extends StatefulWidget {
  const FeatureSlider({super.key});

  @override
  State<FeatureSlider> createState() => _FeatureSliderState();
}

class _FeatureSliderState extends State<FeatureSlider> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  final List<Map<String, dynamic>> features = [
    {
      'title': 'THYCHLOF SARL',
      'isEnterprise': true,
      'nomPME': 'THYCHLOF SARL',
      'description':
          'Entreprise de propreté urbaine, collecte hebdomadaire, tri sélectif et enlèvement à domicile à Yaoundé 3.',
      'image': 'assets/images/tychlof.png',
      'planningZones': [
        {
          'zone': 'Bloc d’Administratif',
          'jour': 'Lundi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Axe École Normal', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
        {'zone': 'Axe du SED', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
        {'zone': 'Axe Polytech', 'jour': 'Lundi', 'heure': '07:00 - 12:00'},
        {
          'zone': 'Axe Central Melen + Bretelles',
          'jour': 'Lundi',
          'heure': '07:00 - 12:00',
        },
        {
          'zone': 'Mur CETIC Ngoa Ekelle',
          'jour': 'Lundi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Brigade Melen', 'jour': null, 'heure': '07:00 - 16:00'},
        {
          'zone': 'Axe Assemblée Nationale',
          'jour': null,
          'heure': '07:00 - 16:00',
        },
        {
          'zone': 'Route Central Olezoua + Ambassade de France',
          'jour': null,
          'heure': '07:00 - 16:00',
        },
        {'zone': 'Quartier Général', 'jour': null, 'heure': '07:00 - 16:00'},
        {'zone': 'Camp Gelain', 'jour': null, 'heure': '07:00 - 16:00'},
        {
          'zone': 'Cité des Nations – CETIC Nko Ekelle',
          'jour': null,
          'heure': '07:00 - 16:00',
        },
        {'zone': 'Dakar', 'jour': null, 'heure': '07:00 - 16:00'},
        {'zone': 'Montée Ponias', 'jour': null, 'heure': '07:00 - 16:00'},
        {'zone': 'Efoulan Lycée', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
        {'zone': 'Efoulan École', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
        {
          'zone': 'Bretelle Mairie d’Efoulan',
          'jour': 'Mardi',
          'heure': '07:00 - 12:00',
        },
        {
          'zone': 'Bretelle chez le Super Maire Efoulan',
          'jour': 'Mardi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Efoulan Pont', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
        {'zone': 'Don Japonais', 'jour': 'Mardi', 'heure': '07:00 - 12:00'},
        {
          'zone': 'Intérieur Terre Rouge',
          'jour': 'Mardi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Olimpic', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
        {'zone': 'Efoulan Lac', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
        {
          'zone': 'Shell Siméyong',
          'jour': 'Mercredi',
          'heure': '13:00 - 16:00',
        },
        {
          'zone': 'Rond Point Vogt',
          'jour': 'Mercredi',
          'heure': '13:00 - 16:00',
        },
        {'zone': 'Schalon', 'jour': 'Mercredi', 'heure': '13:00 - 16:00'},
        {
          'zone': 'Montée Chapelle Obili',
          'jour': 'Mercredi',
          'heure': '13:00 - 16:00',
        },
        {'zone': 'Face Sonel Nsam', 'jour': 'Jeudi', 'heure': '07:00 - 12:00'},
        {
          'zone': 'Porte à Porte Face Sofaving',
          'jour': 'Jeudi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Dépôt Guinness', 'jour': 'Jeudi', 'heure': '07:00 - 12:00'},
        {
          'zone': 'Face Ola Barrière',
          'jour': 'Jeudi',
          'heure': '07:00 - 12:00',
        },
        {
          'zone': 'Mur Sénateur Mama',
          'jour': 'Jeudi',
          'heure': '07:00 - 12:00',
        },
        {
          'zone': 'Après Santa Lucia',
          'jour': 'Jeudi',
          'heure': '07:00 - 12:00',
        },
        {'zone': 'Porte à Porte', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
        {
          'zone': 'Bretelle Afanoyoa',
          'jour': 'Vendredi',
          'heure': '13:00 - 16:00',
        },
        {
          'zone': 'Bretelle Sainte Mary',
          'jour': 'Vendredi',
          'heure': '13:00 - 16:00',
        },
        {'zone': 'Obam Ongola', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
        {'zone': 'Nsam Escal', 'jour': 'Vendredi', 'heure': '13:00 - 16:00'},
        {'zone': 'Colombia', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
        {'zone': 'Axe Obobogo', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
        {'zone': 'Rail Obobogo', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
        {'zone': 'Axe Damas', 'jour': 'Samedi', 'heure': '07:00 - 12:00'},
        {'zone': 'Terre Rouge', 'jour': 'Samedi', 'heure': '13:00 - 16:00'},
        {'zone': 'Victor Hugo', 'jour': 'Samedi', 'heure': '13:00 - 16:00'},
      ],
      'collecteADomicile': true,
      'triSelectifInclus': true,
      'serviceUrgence': false,
      'contactPME':
          'Téléphone : (237) 693 366 871\nEmail : thychlof@gmail.com\nBP: 658 Yaoundé',
    },
    {
      'title': 'Collecte à Domicile',
      'description':
          'Programmez une collecte rapide à votre domicile. Service écologique, rapide et fiable. Gagnez du temps et participez à un environnement plus propre.',
      'image': 'assets/image/collecte.png',
    },
    {
      'title': 'Fidélité Récompensée',
      'description':
          'Gagnez des points à chaque collecte et échangez-les contre des bons d’achat, réductions ou cadeaux écoresponsables. Votre engagement est valorisé !',
      'image': 'assets/image/recompense.png',
    },
    {
      'title': 'Signalement Simplifié',
      'description':
          'Signalez un point de collecte ou un problème d’hygiène en quelques clics via l’application. Votre contribution directe améliore notre cadre de vie.',
      'image': 'assets/image/signaler.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), autoSlide);
  }

  void autoSlide() {
    if (_controller.hasClients) {
      _currentPage = (_currentPage + 1) % features.length;
      _controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      Future.delayed(const Duration(seconds: 4), autoSlide);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: _controller,
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return GestureDetector(
            onTap: () => _showFeatureDetail(feature),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.green.shade50, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        feature['image'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            feature['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            feature['description'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showFeatureDetail(Map<String, dynamic> feature) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.9,
            maxChildSize: 0.95,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              if (feature['isEnterprise'] == true) {
                final zones = feature['planningZones'] as List;
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            feature['image'],
                            height: 120,
                            width: 200,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          feature['nomPME'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(feature['description']),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          children: [
                            if (feature['collecteADomicile'])
                              _buildTag("Collecte à domicile"),
                            if (feature['triSelectifInclus'])
                              _buildTag("Tri sélectif"),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Planning de passage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Table(
                          border: TableBorder.all(color: Colors.green.shade100),
                          columnWidths: const {
                            0: FlexColumnWidth(2),
                            1: FlexColumnWidth(1),
                            2: FlexColumnWidth(1),
                          },
                          children: [
                            const TableRow(
                              decoration: BoxDecoration(
                                color: Color(0xFFE8F5E9),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Zone',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Jour',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Heure',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ...zones.map((zone) {
                              return TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(zone['zone']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(zone['jour'] ?? 'Variable'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(zone['heure']),
                                  ),
                                ],
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Contact",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(feature['contactPME']),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 50),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Fermer"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(feature['image'], height: 120),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          feature['title'],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(feature['description']),
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.center,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(200, 50),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Fermer"),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
    );
  }

  Widget _buildTag(String label) {
    return Chip(
      backgroundColor: Colors.green.shade50,
      label: Text(label, style: const TextStyle(color: Colors.green)),
    );
  }
}
