import 'package:flutter/material.dart';

Future<bool> onWillPop(BuildContext context, String homeRoute) async {
  final navigator = Navigator.of(context);

  if (navigator.canPop()) {
    navigator.pop(); // Go back to previous page
    return false; // Prevent default back action since we handled it
  } else {
    // At root page: navigate to home route instead of exiting
    navigator.pushReplacementNamed(homeRoute);
    return false; // Prevent default back action
  }
}
