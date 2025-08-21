import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/screens/CompleteProfilePage.dart';
import 'package:recycleapp/views/Subsciption/MySubscriptionPage.dart';
import 'package:recycleapp/views/account/edit_profile_screen.dart';
import 'package:recycleapp/views/main_pages/EcoPointsPage.dart';
//import 'package:recycleapp/models/usermodel.dart';
//import 'package:recycleapp/views/Subsciption/user_abonnement_view.dart';
import 'package:recycleapp/views/main_pages/learn.dart';
import 'package:recycleapp/screens/ForgotPasswordPage_screen.dart';
import 'package:recycleapp/screens/LoginPage_screen.dart';
import 'package:recycleapp/screens/Onboardingscreen.dart';
import 'package:recycleapp/screens/RegisterPage.dart';
import 'package:recycleapp/screens/ResetPasswordPage.dart';
import 'package:recycleapp/screens/Splashscreen.dart';
import 'package:recycleapp/screens/SuccessPage.dart';
import 'package:recycleapp/screens/WelcomePage.dart';
import 'package:recycleapp/screens/search_screen.dart';
import 'package:recycleapp/views/main_pages/camera_view.dart';
import 'package:recycleapp/views/main_pages/home_view.dart';
import 'package:recycleapp/views/main_pages/main_scafford.dart';
//
import 'package:recycleapp/views/account/about_view.dart';
import 'package:recycleapp/views/account/adress_view.dart';
import 'package:recycleapp/views/account/appversion_view.dart';
import 'package:recycleapp/views/account/add_card_view.dart';
import 'package:recycleapp/views/account/notif_view.dart';
import 'package:recycleapp/views/main_pages/profile_view.dart';
import 'package:recycleapp/views/account/transaction_view.dart';
import 'package:recycleapp/views/Subsciption/subscription_view.dart';
import 'package:recycleapp/views/signal/Hors_abonne/recyle_form_view.dart';
import 'package:recycleapp/views/signal/a_domicile/signal_domicile.dart';
import 'package:recycleapp/widgets/SubscriptionCheckWrapper.dart';
import 'package:recycleapp/widgets/instants/loading.dart';
import 'package:recycleapp/widgets/instants/success.dart';
import 'package:recycleapp/widgets/instants/tryagain.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    ///Main routes
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder:
              (context, state) =>
                  _buildSlidePage(state, const HomePage(), fromRight: true),
        ),
        //Nelson
        GoRoute(
          path: '/learn',
          pageBuilder:
              (context, state) =>
                  _buildSlidePage(state, const EcoNewsPage(), fromRight: true),
        ),
        //moneze
        GoRoute(
          path: '/search',
          pageBuilder:
              (context, state) => _buildSlidePage(
                state,
                const SearchScreen(),
                fromRight: false,
              ),
        ),
        GoRoute(
          path: '/profile-view',
          pageBuilder:
              (context, state) => _buildSlidePage(
                state,
                const ProfileScreen(),
                fromRight: false,
              ),
        ),
      ],
    ),

    /// Other app routes outside bottom nav
    GoRoute(
      path: '/add-credit-card',
      builder: (context, state) => const CreditCardView(),
    ),
    GoRoute(path: '/about-me', builder: (context, state) => AboutMeScreen()),
    GoRoute(
      path: '/add-address',
      builder: (context, state) => const AddAddressView(),
    ),
    // GoRoute(
    //   path: '/my-subscription',
    //   builder: (context, state) {
    //     final user = state.extra as UserModel?;
    //     if (user == null) {
    //       return const Scaffold(
    //         body: Center(child: Text('Utilisateur non fourni')),
    //       );
    //     }
    //     return UserAbonnementView(user: user);
    //   },
    // ),
    GoRoute(
      path: '/app-version',
      builder: (context, state) => const AppVersionView(),
    ),
    GoRoute(
      path: '/notif-view',
      builder: (context, state) => const NotificationsView(),
    ),
    GoRoute(
      path: '/profile-view',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/transc-view',
      builder: (context, state) => const TransactionsView(),
    ),
    // GoRoute(
    //   path: '/confirm-subscription',
    //   builder: (context, state) => const Confirm(abonnement: null,),
    // ),
    GoRoute(
      path: '/subscription-view',
      builder: (context, state) => SubscriptionListView(),
    ),
    GoRoute(
      path: '/collect-domicile',
      builder: (context, state) => SpecialPickupFormPage(),
    ),
    GoRoute(
      path: '/camera-view',
      builder:
          (context, state) => const CustomCameraView(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/recycle-form-view',
      builder:
          (context, state) => const RecycleFormPage(), // pas dans MainScaffold
    ),

    GoRoute(
      path: '/loading',
      builder: (context, state) => const Loading(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/complete-profile',
      builder: (context, state) => const CompleteProfilePage(),
    ),
    GoRoute(
      path: '/eco-points',
      builder: (context, state) => const EcoPointsPage(),
    ),

    GoRoute(
      path: '/my-subscription',
      builder: (context, state) => const MySubscriptionPage(),
    ),

    GoRoute(
      path: '/edit-profile',
      builder: (context, state) => const EditProfileScreen(),
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) => const ResultPage(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/tryagain',
      builder:
          (context, state) => const TryAgainPage(), // pas dans MainScaffold
    ),
    //Partie MONEZE
    GoRoute(
      path: '/',
      builder:
          (context, state) => const SplashScreen(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const Welcomepage(), // pas dans MainScaffold
    ),

    GoRoute(
      path: '/check',
      name: 'not-subscribed',
      builder: (context, state) => const SubscriptionCheckWrapper(),
    ),

    GoRoute(path: '/onboard', builder: (context, state) => OnboardingScreen()),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginPage(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/register',
      builder:
          (context, state) => const RegisterPage(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/forgot',
      builder:
          (context, state) =>
              const ForgotPasswordPage(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/reset',
      builder:
          (context, state) =>
              const ResetPasswordPage(), // pas dans MainScaffold
    ),
    GoRoute(
      path: '/success',
      builder: (context, state) => const SuccessPage(), // pas dans MainScaffold
    ),
    // GoRoute(
    //   path: '/search',
    //   builder:
    //       (context, state) => const SearchScreen(), // pas dans MainScaffold
    // ),
  ],
);

// ignore: unused_element
CustomTransitionPage _buildSlidePage(
  GoRouterState state,
  Widget child, {
  bool fromRight = true,
}) {
  final beginOffset =
      fromRight ? const Offset(1.0, 0.0) : const Offset(-1.0, 0.0);

  return CustomTransitionPage(
    key: state.pageKey,
    transitionDuration: const Duration(milliseconds: 500), // ⏱ slower animation
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final tween = Tween(
        begin: beginOffset,
        end: Offset.zero,
      ).chain(CurveTween(curve: Curves.easeInOut));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}
