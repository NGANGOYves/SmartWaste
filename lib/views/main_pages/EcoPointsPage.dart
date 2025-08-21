// ignore_for_file: deprecated_member_use, avoid_print, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';

class EcoPointsPage extends StatefulWidget {
  const EcoPointsPage({super.key});

  @override
  State<EcoPointsPage> createState() => _EcoPointsPageState();
}

class _EcoPointsPageState extends State<EcoPointsPage> {
  bool isLoading = true;
  bool hasSubscription = false;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _checkSubscription();
      _isInit = true;
    }
  }

  Future<void> _checkSubscription() async {
    final user = context.read<UserProvider>().user; // use read() here

    if (user == null) {
      setState(() {
        isLoading = false;
        hasSubscription = false;
      });
      return;
    }

    try {
      final query =
          await FirebaseFirestore.instance
              .collection('subscriptions')
              .where('userName', isEqualTo: user.nom)
              .orderBy('dateDebut', descending: true)
              .limit(1)
              .get();

      setState(() {
        hasSubscription = query.docs.isNotEmpty;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur vérification abonnement : $e");
      setState(() {
        isLoading = false;
        hasSubscription = false;
      });
    }
  }

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
          title: const Text("              Points de fidélité"),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body:
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : hasSubscription
                ? _buildEcoPointContent()
                : _buildNoSubscriptionView(),
      ),
    );
  }

  Widget _buildNoSubscriptionView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 60, color: Colors.redAccent),
            const SizedBox(height: 20),
            const Text(
              "Fonctionnalité réservée aux abonnés",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "Veuillez souscrire à un abonnement pour accéder à vos Écopoints.",
              style: TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => context.push('/subscription-view'),
              icon: const Icon(Icons.subscriptions),
              label: const Text("S'abonner maintenant"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEcoPointContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Image.asset(
            'assets/images/ecopoint.png',
            height: 250,
            width: 420,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 20),

          const SizedBox(height: 10),
          const Text(
            "Le système de points de fidélité arrive bientôt !",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 30),
          const Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Icon(Icons.hourglass_empty, color: Colors.orange, size: 40),
                  SizedBox(height: 10),
                  Text(
                    "Disponible très bientôt",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Accumulez des points à chaque collecte et transformez-les en récompenses éco-responsables !",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
