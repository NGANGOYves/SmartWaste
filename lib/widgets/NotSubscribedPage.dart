// ignore_for_file: deprecated_member_use, file_names

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotSubscribedPage extends StatelessWidget {
  const NotSubscribedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/home'); // this pops the current route in go_router
        return false; // prevent default system pop
      },

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Abonnement requis'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/home'),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_amber_rounded,
                  size: 64,
                  color: Colors.green,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Vous devez être abonné pour demander une collecte à domicile.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  icon: const Icon(Icons.subscriptions),
                  label: const Text('S’abonner maintenant'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    fixedSize: Size(250, 60),
                  ),
                  onPressed: () => context.go('/subscription-view'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
