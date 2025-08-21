// ignore_for_file: file_names

import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Privacy Policy")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "We respect your privacy. This app collects only the data required to function properly, "
              "such as authentication credentials and usage statistics. We do not share your data with third parties.\n\n"
              "You can contact us at privacy@yourapp.com for any questions or concerns regarding your data.",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
