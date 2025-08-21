// ignore_for_file: avoid_print, use_build_context_synchronously, curly_braces_in_flow_control_structures, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';
import 'package:recycleapp/services/user_provider.dart';

class PaymentPage extends StatefulWidget {
  final String amount;
  final String formule;
  final bool autorenew;

  const PaymentPage({
    super.key,
    required this.amount,
    required this.formule,
    required this.autorenew,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String selectedMethod = 'Orange';
  bool hasFunds = false;
  bool isLoading = false;

  final phoneController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  String? cardType;

  final paymentImageMap = {
    'Orange': 'assets/images/orange.jpeg',
    'MTN': 'assets/images/mtn.jpg',
    'MASTER-CARD': 'assets/images/master.jpg',
  };

  final _formKey = GlobalKey<FormState>();

  TextInputFormatter cameroonPhoneFormatter = TextInputFormatter.withFunction((
    oldValue,
    newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length > 9) return oldValue;
    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      formatted += digits[i];
      if (i == 2 || i == 5) formatted += '-';
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  });

  Future<DocumentSnapshot?> getExistingSubscription(String userName) async {
    final now = DateTime.now();
    final snapshot =
        await FirebaseFirestore.instance
            .collection('subscriptions')
            .where('userName', isEqualTo: userName)
            .get();

    for (var doc in snapshot.docs) {
      final data = doc.data();
      final dateFin = (data['dateFin'] as Timestamp).toDate();
      if (dateFin.isAfter(now)) {
        return doc;
      }
    }
    return null;
  }

  void _detectCardType(String input) {
    String number = input.replaceAll(' ', '');
    if (number.startsWith('4')) {
      cardType = 'Visa';
    } else if (number.startsWith('5')) {
      cardType = 'MasterCard';
    } else if (number.startsWith('6')) {
      cardType = 'Discover';
    } else {
      cardType = null;
    }
    setState(() {});
  }

  Future<void> _createSubscription() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Utilisateur non connecté.")),
      );
      setState(() => isLoading = false);
      return;
    }

    final existingSub = await getExistingSubscription(user.nom);
    if (existingSub != null) {
      final shouldRenew = await showDialog<bool>(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: const Text("Abonnement existant"),
              content: const Text(
                "Vous avez déjà un abonnement actif.\nSouhaitez-vous le renouveler ?",
              ),
              actions: [
                TextButton(
                  child: const Text("Non"),
                  onPressed: () => Navigator.of(ctx).pop(false),
                ),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.green, // Optionnel : couleur personnalisée
                    ),
                    child: const Text("Renouveler"),
                    onPressed: () => Navigator.of(ctx).pop(true),
                  ),
                ),
              ],
            ),
      );

      if (shouldRenew != true) {
        setState(() => isLoading = false);
        return;
      }

      // Supprimer l'abonnement actuel
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .doc(existingSub.id)
          .delete();
    }

    // Nouvelle création
    final now = DateTime.now();
    final endDate = now.add(const Duration(days: 30));
    final subscriptionData = {
      'userName': user.nom,
      'pmeName': secome.nomEntreprise,
      'typeAbonnement': widget.formule,
      'description': secome.description,
      'prix': widget.amount,
      'dateDebut': now,
      'dateFin': endDate,
      'joursRestants': 30,
      'autorenew': widget.autorenew,
    };

    try {
      await FirebaseFirestore.instance
          .collection('subscriptions')
          .add(subscriptionData);
      context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Erreur : $e")));
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isCard = selectedMethod == 'MASTER-CARD';
    final paymentMethods = paymentImageMap.keys.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Paiement Mobile'),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: isLoading,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pays *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("Cameroun"),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Mode de paiement *",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children:
                          paymentMethods.map((method) {
                            return Expanded(
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        setState(() => selectedMethod = method),
                                child: Container(
                                  height: 60,
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 4,
                                  ),
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          selectedMethod == method
                                              ? Colors.green
                                              : Colors.grey,
                                      width: selectedMethod == method ? 2 : 1,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    paymentImageMap[method]!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                    ),
                    const SizedBox(height: 20),

                    if (!isCard) ...[
                      const Text(
                        "Numéro de téléphone *",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              ),
                            ),
                            child: const Text("237"),
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: phoneController,
                              inputFormatters: [cameroonPhoneFormatter],
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                hintText: '698-123-456',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty)
                                  return 'Champ requis';
                                final digits = value.replaceAll(
                                  RegExp(r'\D'),
                                  '',
                                );
                                if (digits.length != 9 ||
                                    !digits.startsWith('6'))
                                  return 'Numéro invalide';
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ] else ...[
                      const Text(
                        "Numéro de carte *",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      TextFormField(
                        controller: cardNumberController,
                        keyboardType: TextInputType.number,
                        onChanged: _detectCardType,
                        decoration: InputDecoration(
                          hintText: '1234 5678 9012 3456',
                          border: const OutlineInputBorder(),
                          suffixIcon:
                              cardType != null
                                  ? Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Text(
                                      cardType!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                  : null,
                        ),
                        validator: (value) {
                          final digits =
                              value?.replaceAll(RegExp(r'\D'), '') ?? '';
                          if (digits.length < 16) return 'Carte invalide';
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Date d'expiration *",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: expiryController,
                                  keyboardType: TextInputType.datetime,
                                  decoration: const InputDecoration(
                                    hintText: 'MM/AA',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null ||
                                        !RegExp(
                                          r'^\d{2}/\d{2}$',
                                        ).hasMatch(value)) {
                                      return 'Format invalide';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "CVV *",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                TextFormField(
                                  controller: cvvController,
                                  keyboardType: TextInputType.number,
                                  maxLength: 3,
                                  decoration: const InputDecoration(
                                    hintText: '123',
                                    border: OutlineInputBorder(),
                                    counterText: '',
                                  ),
                                  validator: (value) {
                                    if (value == null || value.length != 3)
                                      return 'CVV invalide';
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: 15),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF3CD),
                        border: Border.all(color: const Color(0xFFFFEEBA)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Avant de continuer, assurez-vous de disposer des fonds nécessaires sur votre compte Mobile Money ou bancaire.",
                        style: TextStyle(color: Colors.black87, fontSize: 14),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Checkbox(
                          value: hasFunds,
                          onChanged:
                              isLoading
                                  ? null
                                  : (value) =>
                                      setState(() => hasFunds = value ?? false),
                        ),
                        const Expanded(
                          child: Text(
                            "Je dispose des fonds nécessaires pour continuer cette opération",
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            hasFunds && !isLoading
                                ? () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() => isLoading = true);
                                    await _createSubscription();
                                  }
                                }
                                : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        child: Text("Payer ${widget.amount}"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 4,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
