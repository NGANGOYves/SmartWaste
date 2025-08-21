// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/theme.dart';
import 'package:recycleapp/widgets/buttons/custom_button.dart';
import 'package:recycleapp/widgets/input/custom_text.dart';

class AddAddressView extends StatelessWidget {
  const AddAddressView({super.key});
  Future<bool> _onWillPop(BuildContext context) async {
    final navigator = Navigator.of(context);

    if (navigator.canPop()) {
      navigator.pop(); // pop this page if possible
      return false; // prevent default
    } else {
      // you're on root of navigation — show exit dialog
      final shouldExit = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text("Quitter l'application"),
              content: Text("Voulez-vous vraiment quitter ?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text("Annuler"),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text("Quitter"),
                ),
              ],
            ),
      );

      if (shouldExit == true) {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else {
          exit(0); // Not recommended but possible
        }
      }

      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Address'),
          leading: BackButton(onPressed: () => context.go('/profile-view')),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const CustomTextField1(icon: Icons.person, hintText: 'Name'),
                const CustomTextField1(
                  icon: Icons.email,
                  hintText: 'Email address',
                ),
                const CustomTextField1(
                  icon: Icons.phone,
                  hintText: 'Phone number',
                ),
                const CustomTextField1(
                  icon: Icons.location_on,
                  hintText: 'Address',
                ),
                const CustomTextField1(
                  icon: Icons.markunread_mailbox,
                  hintText: 'Zip code',
                ),
                const CustomTextField1(
                  icon: Icons.location_city,
                  hintText: 'City',
                ),
                const CustomTextField1(icon: Icons.public, hintText: 'Country'),
                const SizedBox(height: 12),
                SwitchListTile(
                  activeColor: AppColors.primary,
                  value: true,
                  onChanged: (val) {},
                  title: const Text('Save this address'),
                ),
                const SizedBox(height: 20),
                GradientButton(text: 'Add Address', onPressed: () {}),
                const SizedBox(height: 40), // space at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
