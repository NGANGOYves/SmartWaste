// ignore: file_names
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/widgets/buttons/custom_button.dart';
import 'package:recycleapp/widgets/input/custom_text.dart';
import 'package:custom_textfield_with_countrycode/custom_textfield_with_countrycode.dart';
import 'package:recycleapp/widgets/re-use/fonction.dart';

class AboutMeScreen extends StatelessWidget {
  final nameController = TextEditingController(text: 'Puan Mihrini');
  final emailController = TextEditingController(text: 'Puan@dpr.ri');
  final phoneController = TextEditingController(text: '+62 202 555 0142');
  final currentPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  AboutMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context, ''),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About me"),
          leading: IconButton(
            onPressed: () => context.go("/profile-view"),
            icon: Icon(Icons.arrow_back),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
        backgroundColor: const Color(0xFFF5F6FA),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                const Text(
                  "Personal Details",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: "Full name",
                  icon: Icons.person,
                  controller: nameController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: "Email",
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 12),

                CustomTextFieldWithCountryCode(
                  controller: TextEditingController(),
                  hintText: 'Enter phone number',
                  countrycode: true,
                  keyboardType: TextInputType.phone,
                  onCountryCodeChanged: (code) {},
                ),

                const SizedBox(height: 24),
                const Text(
                  "Change Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: "Current password",
                  icon: Icons.lock,
                  controller: currentPassController,
                  isPassword: true,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hint: "Confirm password",
                  icon: Icons.lock_outline,
                  controller: confirmPassController,
                  isPassword: true,
                ),
                const SizedBox(height: 50),
                // SizedBox(
                //   width: double.infinity,
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // sauvegarde
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: const Color(0xFF63D351),
                //       padding: const EdgeInsets.symmetric(vertical: 16),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                //     ),
                //     child: const Text(
                //       "Save settings",
                //       style: TextStyle(fontSize: 16),
                //     ),
                //   ),
                // ),
                GradientButton(
                  text: 'Save Settings',
                  onPressed: () => context.go('/profile-view'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
