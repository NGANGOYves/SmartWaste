// import 'package:flutter/material.dart';
// import 'package:recycleapp/widgets/card/bundle_card.dart';
// import 'package:recycleapp/widgets/card/menu_card.dart';
// import 'package:recycleapp/widgets/indicators/clipper.dart';
// import 'package:recycleapp/widgets/indicators/slider.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final TextEditingController _searchController = TextEditingController();
//   final FocusNode _searchFocusNode = FocusNode();
//   String _searchQuery = '';
//   bool _isSearching = false;

//   final List<MenuCard> allMenuCards = const [
//     MenuCard(
//       route: '/home',
//       icon: Icons.location_pin,
//       label: "Collecte à Domicile",
//       color: Colors.pinkAccent,
//     ),
//     MenuCard(
//       route: '/subscription-view',
//       icon: Icons.subscriptions,
//       label: "Abonnement",
//       color: Colors.orangeAccent,
//     ),
//     MenuCard(
//       route: '/home',
//       icon: Icons.favorite,
//       label: "Point de Fidélité",
//       color: Colors.pink,
//     ),
//     MenuCard(
//       route: '/home',
//       icon: Icons.qr_code,
//       label: "Signalement",
//       color: Colors.grey,
//     ),
//   ];

//   List<MenuCard> get filteredCards {
//     if (_searchQuery.isEmpty) return allMenuCards;
//     return allMenuCards.where((card) {
//       return card.label.toLowerCase().contains(_searchQuery.toLowerCase());
//     }).toList();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _searchFocusNode.addListener(() {
//       setState(() {
//         _isSearching = _searchFocusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     _searchFocusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ignore: deprecated_member_use
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F7FA),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               child: Column(
//                 children: [
//                   // Background image with curve
//                   Stack(
//                     children: [
//                       ClipPath(
//                         clipper: BottomConvexClipper(),
//                         child: Container(
//                           height: 250,
//                           width: double.infinity,
//                           decoration: const BoxDecoration(
//                             image: DecorationImage(
//                               image: AssetImage('assets/image/bg.png'),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 30),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 20,
//                         ),
//                         child: Container(
//                           margin: const EdgeInsets.only(
//                             top: 20,
//                             left: 16,
//                             right: 16,
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 12,
//                           ),
//                           decoration: BoxDecoration(
//                             // ignore: deprecated_member_use
//                             color: Colors.black.withOpacity(
//                               0.4,
//                             ), // subtle dark overlay
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             "Bienvenue sur Recyler, votre assistant éco-responsable 👋",
//                             style: Theme.of(
//                               context,
//                             ).textTheme.titleMedium?.copyWith(
//                               color: Colors.white,
//                               fontWeight: FontWeight.w600,
//                               shadows: [
//                                 Shadow(
//                                   // ignore: deprecated_member_use
//                                   color: Colors.black.withOpacity(0.6),
//                                   offset: const Offset(1, 1),
//                                   blurRadius: 2,
//                                 ),
//                               ],
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),

//                       // Search bar
//                       Padding(
//                         padding: const EdgeInsets.only(
//                           top: 80,
//                           left: 16,
//                           right: 16,
//                         ),
//                         child: TextField(
//                           controller: _searchController,
//                           focusNode: _searchFocusNode,
//                           onChanged: (value) {
//                             setState(() => _searchQuery = value);
//                           },
//                           decoration: InputDecoration(
//                             hintText: "Rechercher une fonctionnalité...",
//                             filled: true,
//                             fillColor: Colors.white,
//                             prefixIcon: const Icon(Icons.search),
//                             suffixIcon:
//                                 _searchQuery.isNotEmpty
//                                     ? IconButton(
//                                       icon: const Icon(Icons.close),
//                                       onPressed: () {
//                                         _searchController.clear();
//                                         _searchFocusNode
//                                             .unfocus(); // Cache le clavier
//                                         setState(() {
//                                           _searchQuery = '';
//                                           _isSearching = false;
//                                         });
//                                       },
//                                     )
//                                     : null,
//                             border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide.none,
//                             ),
//                           ),
//                         ),
//                       ),

//                       // Promo Card (hidden while searching)
//                       if (!_isSearching)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             top: 140,
//                             left: 16,
//                             right: 16,
//                           ),
//                           child: PromoCard(),
//                         ),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Feature Slider (hidden while searching)
//                   if (!_isSearching) const FeatureSlider(),

//                   // Grid menu
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     child: GridView.count(
//                       shrinkWrap: true,
//                       physics: const NeverScrollableScrollPhysics(),
//                       crossAxisCount: 2,
//                       crossAxisSpacing: 16,
//                       mainAxisSpacing: 16,
//                       childAspectRatio: 1,
//                       children: filteredCards,
//                     ),
//                   ),

//                   const SizedBox(height: 40),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
