// ignore_for_file: use_build_context_synchronously, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/user_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndRedirect();
  }

  Future<void> _checkAuthAndRedirect() async {
    await Future.delayed(const Duration(seconds: 3)); // show logo for 2s

    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    final user = FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {
      await context.read<UserProvider>().fetchUserData();
      context.go('/home');
    } else {
      if (hasSeenOnboarding) {
        context.go('/welcome');
      } else {
        context.go('/onboard');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/recycling_logo.jpeg',
              width: 100,
              height: 100,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.recycling,
                  size: 100,
                  color: Color(0xFF00C7B0),
                );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'Smart Waste',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF28B446),
              ),
            ),
            const SizedBox(height: 50),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF28B446)),
            ),
          ],
        ),
      ),
    );
  }
}
