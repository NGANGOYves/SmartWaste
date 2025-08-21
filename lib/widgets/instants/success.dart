// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final String message1 = 'Votre requête a été envoyée avec succès !';
  final String message2 =
      'Nous passerons bientôt pour effectuer la collecte des déchets.';

  bool showMessage1 = false;
  bool showMessage2 = false;

  @override
  void initState() {
    super.initState();

    // Affichage progressif des textes
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showMessage1 = true;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        showMessage2 = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  // Animation de succès
                  Lottie.network(
                    'https://lottie.host/6d0ade42-56a4-4158-ad44-24390a83759d/nAXCx8CU2L.json',
                    width: 200,
                    height: 200,
                  ),

                  const SizedBox(height: 24),

                  // Premier message
                  AnimatedOpacity(
                    opacity: showMessage1 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      message1,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Deuxième message
                  AnimatedOpacity(
                    opacity: showMessage2 ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      message2,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Bouton de retour à l'accueil
                  if (showMessage2)
                    ElevatedButton(
                      onPressed: () async {
                        // Affiche le spinner
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder:
                              (ctx) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                        );

                        // Simule un court délai (par exemple 1.5 secondes)
                        await Future.delayed(Duration(seconds: 2));

                        // Ferme le spinner
                        if (context.mounted) {
                          Navigator.of(context).pop(); // Ferme le dialog
                          context.go(
                            '/home',
                          ); // Redirige vers la page d'accueil
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          13,
                          230,
                          158,
                        ),
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
                        "Retour à l'accueil",
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
