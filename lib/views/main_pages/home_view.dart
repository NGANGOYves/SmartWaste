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
//   bool _isLoading = false;

//   final List<MenuCard> allMenuCards = const [
//     MenuCard(
//       route: '/collect-domicile',
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
//       route: '/recycle-form-view',
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
//                       Row(
//                         children: [
//                           const SizedBox(width: 35),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 16,
//                               vertical: 20,
//                             ),
//                             child: Container(
//                               margin: const EdgeInsets.only(
//                                 top: 20,
//                                 left: 16,
//                                 right: 16,
//                               ),
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 16,
//                                 vertical: 12,
//                               ),
//                               decoration: BoxDecoration(
//                                 // ignore: deprecated_member_use
//                                 color: Colors.black.withOpacity(0.4),
//                                 borderRadius: BorderRadius.circular(12),
//                               ),
//                               child: Text(
//                                 "Bienvenue sur SmartWaste",
//                                 style: Theme.of(
//                                   context,
//                                 ).textTheme.titleMedium?.copyWith(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w600,
//                                   shadows: [
//                                     Shadow(
//                                       // ignore: deprecated_member_use
//                                       color: Colors.black.withOpacity(0.6),
//                                       offset: const Offset(1, 1),
//                                       blurRadius: 2,
//                                     ),
//                                   ],
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ),
//                         ],
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
//                           onChanged: (value) async {
//                             setState(() {
//                               _searchQuery = value;
//                               _isLoading = true;
//                             });

//                             // Simulate quick loading
//                             await Future.delayed(
//                               const Duration(milliseconds: 400),
//                             );

//                             setState(() {
//                               _isLoading = false;
//                             });
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
//                                         _searchFocusNode.unfocus();
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

//                   // Grid or Feedback
//                   Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 10,
//                     ),
//                     child:
//                         _isLoading
//                             ? const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 40),
//                               child: CircularProgressIndicator(),
//                             )
//                             : filteredCards.isEmpty
//                             ? const Padding(
//                               padding: EdgeInsets.symmetric(vertical: 40),
//                               child: Text(
//                                 'Aucun résultat trouvé',
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.grey,
//                                 ),
//                                 textAlign: TextAlign.center,
//                               ),
//                             )
//                             : GridView.count(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               crossAxisCount: 2,
//                               crossAxisSpacing: 16,
//                               mainAxisSpacing: 16,
//                               childAspectRatio: 1,
//                               children: filteredCards,
//                             ),
//                   ),

// ignore_for_file: deprecated_member_use

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
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';
import 'package:recycleapp/views/Subsciption/subscription_card.dart';
import 'package:recycleapp/widgets/buttons/notif_buton.dart';
import 'package:recycleapp/widgets/card/menu_card.dart';
import 'package:recycleapp/widgets/indicators/clipper.dart';
import 'package:recycleapp/widgets/indicators/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';
  bool _isSearching = false;
  bool _isLoading = false;

  final List<MenuCard> allMenuCards = const [
    MenuCard(
      route: '/check',
      icon: Icons.location_pin,
      label: "Collecte à Domicile",
      color: Colors.pinkAccent,
    ),
    MenuCard(
      route: '/subscription-view',
      icon: Icons.subscriptions,
      label: "Abonnement",
      color: Colors.orangeAccent,
    ),
    MenuCard(
      route: '/eco-points',
      icon: Icons.favorite,
      label: "Point de Fidélité",
      color: Colors.pink,
    ),
    MenuCard(
      route: '/recycle-form-view',
      icon: Icons.qr_code,
      label: "Signalement",
      color: Colors.grey,
    ),
  ];

  List<MenuCard> get filteredCards {
    if (_searchQuery.isEmpty) return allMenuCards;
    return allMenuCards.where((card) {
      return card.label.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _searchFocusNode.addListener(() {
      setState(() {
        _isSearching = _searchFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final username = user?.nom.trim();
    final welcomeMessage =
        (username != null && username.isNotEmpty)
            ? "Bienvenue $username"
            : "Bienvenue sur SmartWaste";

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Background with clip
                      ClipPath(
                        clipper: BottomConvexClipper(),
                        child: Container(
                          height: 250,
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/image/bg.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(width: 290),
                          NotificationCollecteButton(username: user!.nom),
                        ],
                      ),

                      // Welcome Text
                      Positioned(
                        top: 40,
                        left: 35,
                        right: 35,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            welcomeMessage,
                            style: Theme.of(
                              context,
                            ).textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: const Offset(1, 1),
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      // Search bar
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          left: 16,
                          right: 16,
                        ),
                        child: TextField(
                          controller: _searchController,
                          focusNode: _searchFocusNode,
                          onChanged: (value) async {
                            setState(() {
                              _searchQuery = value;
                              _isLoading = true;
                            });

                            await Future.delayed(
                              const Duration(milliseconds: 400),
                            );

                            setState(() {
                              _isLoading = false;
                            });
                          },
                          decoration: InputDecoration(
                            hintText: "Rechercher une fonctionnalité...",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon:
                                _searchQuery.isNotEmpty
                                    ? IconButton(
                                      icon: const Icon(Icons.close),
                                      onPressed: () {
                                        _searchController.clear();
                                        _searchFocusNode.unfocus();
                                        setState(() {
                                          _searchQuery = '';
                                          _isSearching = false;
                                        });
                                      },
                                    )
                                    : null,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),

                      // PromoCard
                      if (!_isSearching)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 160,
                            left: 16,
                            right: 16,
                          ),
                          child: SubscriptionCard(username: username!),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  if (!_isSearching) const FeatureSlider(),

                  // Menu Grid
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child:
                        _isLoading
                            ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: CircularProgressIndicator(),
                            )
                            : filteredCards.isEmpty
                            ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 40),
                              child: Text(
                                'Aucun résultat trouvé',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                            : GridView.count(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: 1,
                              children: filteredCards,
                            ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
