// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class TryAgainPage extends StatelessWidget {
  const TryAgainPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkGreen = Color(0xFF2E7D32);

    return WillPopScope(
      onWillPop: () async {
        context.go('/home'); // this pops the current route in go_router
        return false; // prevent default system pop
      },
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Remplace ce lien par ton animation Lottie
                  Lottie.network(
                    'https://lottie.host/c411e534-c040-4483-b5ed-07a29d377f49/oBaNnPOlCm.json',
                    width: 300,
                    height: 400,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Connexion Internet absente !\n\nVeuillez réessayer plus tard.',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      context.go('/loading'); // Relancer la tentative
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: darkGreen,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      'Réessayer',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
