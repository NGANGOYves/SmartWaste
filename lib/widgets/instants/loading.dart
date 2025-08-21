// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  final List<String> messages = [
    'Nous envoyons vos données...',
    'Veuillez patienter...',
  ];

  int _messageIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Démarrer les messages avec délai
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_messageIndex < messages.length - 1) {
        setState(() => _messageIndex++);
      } else {
        _timer?.cancel();

        // Après le dernier message, tester la connexion
        Future.delayed(const Duration(seconds: 1), () async {
          final hasInternet = await _checkInternetConnection();
          if (!mounted) return;
          if (hasInternet) {
            context.go('/success');
          } else {
            context.go('/tryagain');
          }
        });
      }
    });
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.network(
                  'https://lottie.host/48aef1e5-2367-4e62-84f5-d9f6e2ad1b83/6oIlwJkUzp.json',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 24),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: Text(
                    messages[_messageIndex],
                    key: ValueKey(_messageIndex),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
