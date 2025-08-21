// ignore_for_file: file_names

import 'package:flutter/material.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Terms of Service")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "Terms of Service",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "By using this app, you agree to the following terms:\n\n"
              "1. You shall not misuse the app.\n"
              "2. You agree to provide accurate information.\n"
              "3. We reserve the right to suspend your access if misuse is detected.\n\n"
              "These terms may be updated from time to time. Continued use constitutes acceptance of the changes.",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
