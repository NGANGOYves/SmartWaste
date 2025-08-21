// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Welcomepage extends StatelessWidget {
  const Welcomepage({super.key});

  Future<bool> _onWillPop(BuildContext context) async {
    bool exit = false;
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Quitter l’application ?'),
            content: const Text(
              'Voulez-vous vraiment quitter l\'application ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Non'),
              ),
              TextButton(
                onPressed: () {
                  exit = true;
                  Navigator.of(context).pop(true);
                },
                child: const Text('Oui'),
              ),
            ],
          ),
    );
    return exit;
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/image/Welcom.png',
                fit: BoxFit.cover,
                height: screenSize.height * 1.1,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      height: screenSize.height * 0.5,
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'Image manquante',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                    ),
              ),
            ),

            // Content
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: screenSize.height * 0.35),
                Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.recycling,
                      color: Color(0xFF00C7B0),
                      size: 60,
                    ),
                  ),
                ),
                const SizedBox(height: 50),

                // Connexion button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ElevatedButton(
                    onPressed: () => context.go('/login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF28B446),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Connexion',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Register button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: OutlinedButton(
                    onPressed: () => context.go('/register'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      minimumSize: const Size.fromHeight(55),
                      side: const BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Créer un compte',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Guest button (currently empty)
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFF00C7B0),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                  ),
                  child: const Text(''),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
