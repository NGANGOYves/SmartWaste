// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LicensePageApp extends StatelessWidget {
  const LicensePageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("License")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              "License Agreement",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              "This app is licensed under the MIT License.\n\n"
              "Permission is hereby granted, free of charge, to any person obtaining a copy "
              "of this software and associated documentation files (the \"Software\"), to deal "
              "in the Software without restriction, including without limitation the rights "
              "to use, copy, modify, merge, publish, distribute, sublicense, and/or sell "
              "copies of the Software, and to permit persons to whom the Software is "
              "furnished to do so, subject to the following conditions:\n\n"
              "[...]",
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
