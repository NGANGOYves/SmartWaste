// // ignore_for_file: file_names

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:recycleapp/models/Onboardingmodel.dart';
// import 'package:recycleapp/widgets/user/Onboardingpage.dart';

// // ==============================================================================
// // ÉCRAN D'INTRODUCTION
// // Gère les pages d’introduction via un PageView.
// // ==============================================================================
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   final PageController _pageController = PageController();
//   int _currentPage = 0;

//   // Données pour chaque page d'introduction
//   final List<OnboardingPageData> onboardingPages = [
//     OnboardingPageData(
//       imagePath: 'assets/image/AdobeStock_290929282-scaled.jpeg',
//       title: 'Vendez vos déchets facilement',
//       description:
//           'Vendez vos déchets aux points de collecte les plus proches et gagnez des récompenses !',
//     ),
//     OnboardingPageData(
//       imagePath: 'assets/image/The-Importance-of-Recycling.jpg',
//       title: 'Tout le monde peut recycler',
//       description:
//           'Recyclez les biens usagés et contribuez à préserver la beauté et la durabilité de notre environnement.',
//     ),
//     OnboardingPageData(
//       imagePath: 'assets/image/Recycling-Bin-Crop-1024x704.jpg',
//       title: 'Recyclez dans les lieux proches',
//       description:
//           'Trouvez des centres de recyclage pratiques près de chez vous et contribuez à une communauté plus propre.',
//     ),
//     OnboardingPageData(
//       imagePath: 'assets/image/iStock.jpeg',
//       title: 'Rejoignez notre communauté',
//       description:
//           'Faites partie du mouvement de gestion des déchets et contribuez à bâtir un avenir durable !',
//     ),
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         if (_currentPage > 0) {
//           _pageController.previousPage(
//             duration: const Duration(milliseconds: 300),
//             curve: Curves.easeInOut,
//           );
//           return false; // prevent popping the screen
//         }
//         return true; // allow default behavior (exit app)
//       },
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Column(
//           children: [
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: onboardingPages.length,
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page;
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   return OnboardingPage(data: onboardingPages[index]);
//                 },
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 24.0,
//                 vertical: 20.0,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   if (_currentPage > 0)
//                     Expanded(
//                       child: OutlinedButton(
//                         onPressed: () {
//                           _pageController.previousPage(
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeInOut,
//                           );
//                         },
//                         style: OutlinedButton.styleFrom(
//                           foregroundColor: const Color(0xFF000000),
//                           side: const BorderSide(color: Color(0xFF000000)),
//                           minimumSize: const Size(double.infinity, 50),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text('Retour'),
//                       ),
//                     )
//                   else
//                     const Expanded(child: SizedBox.shrink()),

//                   SizedBox(
//                     width:
//                         _currentPage > 0 &&
//                                 _currentPage < onboardingPages.length - 1
//                             ? 16
//                             : 0,
//                   ),

//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         if (_currentPage < onboardingPages.length - 1) {
//                           _pageController.nextPage(
//                             duration: const Duration(milliseconds: 400),
//                             curve: Curves.easeInOut,
//                           );
//                         } else {
//                           context.go('/welcome');
//                         }
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF28B446),
//                         foregroundColor: Colors.white,
//                         minimumSize: const Size(double.infinity, 50),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         elevation: 5,
//                       ),
//                       child: Text(
//                         _currentPage == onboardingPages.length - 1
//                             ? 'Commençons'
//                             : 'Suivant →',
//                         style: const TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: use_build_context_synchronously, deprecated_member_use, file_names

// onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recycleapp/models/Onboardingmodel.dart';
import 'package:recycleapp/widgets/user/Onboardingpage.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPageData> onboardingPages = [
    OnboardingPageData(
      imagePath: 'assets/image/AdobeStock_290929282-scaled.jpeg',
      title: 'Vendez vos déchets facilement',
      description:
          'Vendez vos déchets aux points de collecte les plus proches et gagnez des récompenses !',
    ),
    OnboardingPageData(
      imagePath: 'assets/image/The-Importance-of-Recycling.jpg',
      title: 'Tout le monde peut recycler',
      description:
          'Recyclez les biens usagés et contribuez à préserver la beauté et la durabilité de notre environnement.',
    ),
    OnboardingPageData(
      imagePath: 'assets/image/Recycling-Bin-Crop-1024x704.jpg',
      title: 'Recyclez dans les lieux proches',
      description:
          'Trouvez des centres de recyclage pratiques près de chez vous et contribuez à une communauté plus propre.',
    ),
    OnboardingPageData(
      imagePath: 'assets/image/iStock.jpeg',
      title: 'Rejoignez notre communauté',
      description:
          'Faites partie du mouvement de gestion des déchets et contribuez à bâtir un avenir durable !',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    context.go('/welcome');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_currentPage > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPage(data: onboardingPages[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF000000),
                          side: const BorderSide(color: Color(0xFF000000)),
                          minimumSize: const Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text('Retour'),
                      ),
                    )
                  else
                    const Expanded(child: SizedBox.shrink()),

                  SizedBox(
                    width:
                        _currentPage > 0 &&
                                _currentPage < onboardingPages.length - 1
                            ? 16
                            : 0,
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage < onboardingPages.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          _completeOnboarding(); // ✅ set as seen
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF28B446),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        _currentPage == onboardingPages.length - 1
                            ? 'Commençons'
                            : 'Suivant →',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
