// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:recycleapp/models/usermodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;

  UserModel? get user => _user;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  /// Call this after login/signup to fetch user profile
  Future<void> fetchUserData() async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) return;

    final doc = await _firestore.collection('users').doc(currentUser.uid).get();

    if (doc.exists) {
      _user = UserModel.fromMap(currentUser.uid, doc.data()!);
      notifyListeners();
    }
  }

  void clearUser() {
    _user = null;
    notifyListeners();
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final uid = prefs.getString("user_id");
    if (uid == null) return;

    _user = UserModel(
      uid: uid,
      nom: prefs.getString("user_nom") ?? '',
      email: prefs.getString("user_email") ?? '',
      photoProfil: prefs.getString("user_photo") ?? '',
      adresse: prefs.getString("user_adresse") ?? '',
      telephone: prefs.getString("user_telephone") ?? '',

      // Ajoute d'autres champs si nécessaires
    );

    notifyListeners();
  }

  Future<void> logoutAndClearPrefs(BuildContext context) async {
    // Show loader
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      await FirebaseAuth.instance.signOut();

      _user = null;
      notifyListeners();

      if (context.mounted) {
        // 👇 Await the closing of the dialog before navigating
        await Navigator.of(context).maybePop();

        // Now navigate safely
        if (context.mounted) {
          context.go('/login');
        }
      }
    } catch (e) {
      if (context.mounted) {
        await Navigator.of(context).maybePop(); // Close loader
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erreur de déconnexion : $e")));
      }
    }
  }
}
