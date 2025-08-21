// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:recycleapp/models/entreprise_abonnement_model.dart';

class SpecialPickupFormPage extends StatefulWidget {
  const SpecialPickupFormPage({super.key});

  @override
  State<SpecialPickupFormPage> createState() => _SpecialPickupFormPageState();
}

class _SpecialPickupFormPageState extends State<SpecialPickupFormPage> {
  final _formKey = GlobalKey<FormState>();

  final _quantityController = TextEditingController();
  final _infoController = TextEditingController();
  final _dateController = TextEditingController();
  final _manualLocationController = TextEditingController();

  String? _localisation;
  bool _useAutoLocation = false;

  // ignore: unused_field
  final _addressController = TextEditingController();

  final List<String> _selectedWasteTypes = [];
  bool _confirmExtraFees = false;

  final wasteTypes = [
    'Plastique',
    'Papier',
    'Fer',
    'Aluminium',
    'Verre',
    'Électronique',
    'Organique',
    'Autre',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _askLocation());
  }

  Future<void> _askLocation() async {
    final useLocation = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text('Partage de localisation'),
            content: Text(
              'Souhaitez-vous que l\'application utilise votre position actuelle ?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Manuel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text('Automatique'),
              ),
            ],
          ),
    );

    if (useLocation == true) {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        final pos = await Geolocator.getCurrentPosition();
        final placemarks = await placemarkFromCoordinates(
          pos.latitude,
          pos.longitude,
        );
        final place = placemarks.first;
        setState(() {
          _useAutoLocation = true;
          _localisation =
              '${place.street}, ${place.locality}, ${place.country}';
        });
      }
    }
  }

  void _submit() async {
    if (!_confirmExtraFees) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Vous devez accepter les frais supplémentaires éventuels.',
          ),
        ),
      );
      return;
    }

    if (_selectedWasteTypes.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Sélectionnez au moins un type de déchet')),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final user = FirebaseAuth.instance.currentUser;

      final request = {
        'user': user?.displayName ?? 'Inconnu',
        'userEmail': '${secome.nomEntreprise}@smartwaste.com',
        'telephone': user?.phoneNumber ?? '',
        'types': _selectedWasteTypes,
        'commentaire': _infoController.text,
        'date': _dateController.text,
        'adresse':
            _useAutoLocation ? _localisation : _manualLocationController.text,
        'ville': _extractVille(_localisation ?? _manualLocationController.text),
        'status': 'En attente',
        'createdAt': DateTime.now().toIso8601String(),
      };

      await FirebaseFirestore.instance
          .collection('collectes_domicile')
          .add(request);

      context.go('/loading'); // or show success dialog
    }
  }

  String _extractVille(String fullAddress) {
    try {
      final parts = fullAddress.split(',');
      return parts.length > 1 ? parts[1].trim() : fullAddress;
    } catch (e) {
      return fullAddress;
    }
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Colors.green),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      filled: true,
      fillColor: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/home'); // this pops the current route in go_router
        return false; // prevent default system pop
      },
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Demande de collecte à domicile'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => context.go('/home'),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Veuillez remplir soigneusement les informations ci-dessous.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ).animate().fade(duration: 500.ms),

                SizedBox(height: 16),

                TextFormField(
                  controller: _quantityController,
                  decoration: _inputDecoration(
                    'Quantité approximative (ex. 3 sacs, 1 poubelle pleine)',
                    Icons.scale,
                  ),
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'Indiquez la quantité'
                              : null,
                ),
                SizedBox(height: 16),

                // Multi-sélection des types de déchets
                ExpansionTile(
                  title: Text(
                    'Types de déchets sélectionnés (${_selectedWasteTypes.length})',
                  ),
                  leading: Icon(Icons.delete, color: Colors.green),
                  children:
                      wasteTypes
                          .map(
                            (type) => CheckboxListTile(
                              title: Text(type),
                              value: _selectedWasteTypes.contains(type),
                              onChanged: (val) {
                                setState(() {
                                  if (val == true) {
                                    _selectedWasteTypes.add(type);
                                  } else {
                                    _selectedWasteTypes.remove(type);
                                  }
                                });
                              },
                              activeColor: Colors.green,
                            ),
                          )
                          .toList(),
                ),
                SizedBox(height: 16),

                // Date souhaitée
                TextFormField(
                  controller: _dateController,
                  decoration: _inputDecoration(
                    'Date souhaitée',
                    Icons.date_range,
                  ),
                  readOnly: true,
                  onTap: () async {
                    final date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now().add(Duration(days: 1)),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(Duration(days: 30)),
                    );
                    if (date != null) {
                      _dateController.text =
                          '${date.day}/${date.month}/${date.year}';
                    }
                  },
                  validator:
                      (val) =>
                          val == null || val.isEmpty ? 'Date requise' : null,
                ),
                SizedBox(height: 16),

                // Localisation field
                TextFormField(
                  controller:
                      _useAutoLocation
                          ? TextEditingController(text: _localisation)
                          : _manualLocationController,
                  readOnly: _useAutoLocation,
                  decoration: _inputDecoration(
                    'Localisation',
                    Icons.location_on,
                  ),
                  validator:
                      (val) =>
                          val == null || val.isEmpty
                              ? 'Localisation requise'
                              : null,
                ),
                SizedBox(height: 16),

                // Observations
                TextFormField(
                  controller: _infoController,
                  decoration: _inputDecoration(
                    'Observations supplémentaires',
                    Icons.info,
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),

                // Confirmation frais supplémentaires
                CheckboxListTile(
                  title: Text(
                    'Je confirme accepter les frais supplémentaires éventuels',
                  ),
                  value: _confirmExtraFees,
                  onChanged:
                      (val) => setState(() => _confirmExtraFees = val ?? false),
                  activeColor: Colors.green,
                ),
                SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Envoyer ma demande',
                    style: TextStyle(fontSize: 16),
                  ),
                ).animate().slideY(begin: 0.3).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
