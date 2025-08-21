// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppVersionView extends StatelessWidget {
  const AppVersionView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/profile-view'); // this pops the current route in go_router
        return false; // prevent default system pop
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('App Version'),
          leading: BackButton(onPressed: () => context.go('/profile-view')),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset("assets/icon/playstore.png"),
                ),
                const SizedBox(height: 24),

                const SizedBox(height: 8),
                const SizedBox(height: 8),
                const Text('Version 1.0.0'),
                const SizedBox(height: 8),
                const Text('©2025 SmartWaste Inc.'),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger(child: const Text('Visiter le siteweb'));
                  },
                  child: const Text('License'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
