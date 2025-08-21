// ignore_for_file: avoid_print, use_build_context_synchronously, deprecated_member_use, curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class RecycleFormPage extends StatefulWidget {
  final File? initialImage;
  const RecycleFormPage({super.key, this.initialImage});

  @override
  State<RecycleFormPage> createState() => _RecycleFormPageState();
}

class _RecycleFormPageState extends State<RecycleFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _infoController = TextEditingController();
  final _emailController = TextEditingController();
  final _manualLocationController = TextEditingController();
  bool _isSubmitting = false;

  File? _pickedImage;
  String? _localisation;
  double? _latitude;
  double? _longitude;
  bool _useAutoLocation = false;
  bool _agreeData = false;
  bool _newsletter = false;
  bool _anonymous = false;
  List<String> _availableLocations = [];

  @override
  void initState() {
    super.initState();
    _pickedImage = widget.initialImage;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _askLocation();
      if (!_useAutoLocation) await _loadLocations();
    });
  }

  Future<void> _loadLocations() async {
    final snapshot =
        await FirebaseFirestore.instance
            .collection('points_de_rammassage')
            .get();

    final Set<String> locations = {};
    for (final doc in snapshot.docs) {
      final data = doc.data();
      if (data.containsKey('name')) {
        locations.add(data['name']);
      }
    }

    setState(() {
      _availableLocations = locations.toList();
    });
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
          _latitude = pos.latitude;
          _longitude = pos.longitude;
        });
      }
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() => _pickedImage = File(pickedFile.path));
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final fileName =
          'signalements/${DateTime.now().millisecondsSinceEpoch}.jpg';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Erreur de téléchargement de l\'image : $e');
      return null;
    }
  }

  // void _submit() async {
  //   if (!_agreeData) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Vous devez accepter les données fournies')),
  //     );
  //     return;
  //   }

  //   if (_formKey.currentState!.validate()) {
  //     try {
  //       final querySnapshot =
  //           await FirebaseFirestore.instance
  //               .collection('points_de_rammassage')
  //               .get();

  //       bool found = false;

  //       for (var doc in querySnapshot.docs) {
  //         final data = doc.data();
  //         if (data.containsKey('position')) {
  //           final pos = data['position'];
  //           final double docLat = pos['lat'];
  //           final double docLng = pos['lng'];

  //           if (_useAutoLocation && _latitude != null && _longitude != null) {
  //             final distance = Geolocator.distanceBetween(
  //               _latitude!,
  //               _longitude!,
  //               docLat,
  //               docLng,
  //             );

  //             if (distance <= 100) {
  //               await FirebaseFirestore.instance
  //                   .collection('points_de_rammassage')
  //                   .doc(doc.id)
  //                   .update({'signale': true});
  //               found = true;
  //               break;
  //             }
  //           } else if (!_useAutoLocation &&
  //               _manualLocationController.text.isNotEmpty &&
  //               data['name'].toString().toLowerCase().trim().contains(
  //                 _manualLocationController.text.toLowerCase().trim(),
  //               )) {
  //             await FirebaseFirestore.instance
  //                 .collection('points_de_rammassage')
  //                 .doc(doc.id)
  //                 .update({'signale': true});
  //             found = true;
  //             break;
  //           }
  //         }
  //       }

  //       if (found) {
  //         if (_pickedImage != null) {
  //           await _uploadImage(_pickedImage!);
  //         }
  //         context.go('/loading');
  //       } else {
  //         await showDialog(
  //           context: context,
  //           builder:
  //               (context) => AlertDialog(
  //                 title: Text('Aucun point trouvé'),
  //                 content: Text(
  //                   'Aucun point de ramassage correspondant n’a été trouvé.\n\n'
  //                   'Veuillez vérifier votre position GPS ou saisir une adresse manuelle valide.',
  //                 ),
  //                 actions: [
  //                   TextButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     child: Text('OK'),
  //                   ),
  //                 ],
  //               ),
  //         );
  //       }
  //     } catch (e) {
  //       ScaffoldMessenger.of(
  //         context,
  //       ).showSnackBar(SnackBar(content: Text('Erreur : ${e.toString()}')));
  //     }
  //   }
  // }
  void _submit() async {
    if (!_agreeData) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vous devez accepter les données fournies'),
        ),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final querySnapshot =
          await FirebaseFirestore.instance
              .collection('points_de_rammassage')
              .get();

      bool found = false;

      for (var doc in querySnapshot.docs) {
        final data = doc.data();
        if (data.containsKey('position')) {
          final pos = data['position'];
          final double docLat = pos['lat'];
          final double docLng = pos['lng'];

          if (_useAutoLocation && _latitude != null && _longitude != null) {
            final distance = Geolocator.distanceBetween(
              _latitude!,
              _longitude!,
              docLat,
              docLng,
            );

            if (distance <= 100) {
              await FirebaseFirestore.instance
                  .collection('points_de_rammassage')
                  .doc(doc.id)
                  .update({'signale': true});
              found = true;
              break;
            }
          } else if (!_useAutoLocation &&
              _manualLocationController.text.isNotEmpty &&
              data['name'].toString().toLowerCase().trim().contains(
                _manualLocationController.text.toLowerCase().trim(),
              )) {
            await FirebaseFirestore.instance
                .collection('points_de_rammassage')
                .doc(doc.id)
                .update({'signale': true});
            found = true;
            break;
          }
        }
      }

      if (found) {
        final imageToUpload = _pickedImage;
        context.go('/loading');

        if (imageToUpload != null) {
          await _uploadImage(imageToUpload);
        }
      } else {
        if (mounted) {
          setState(() => _isSubmitting = false);
          await showDialog(
            context: context,
            builder:
                (context) => AlertDialog(
                  title: const Text('Aucun point trouvé'),
                  content: const Text(
                    'Aucun point de ramassage correspondant n’a été trouvé.\n\n'
                    'Veuillez vérifier votre position GPS ou saisir une adresse manuelle valide.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('OK'),
                    ),
                  ],
                ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erreur : ${e.toString()}')));
      }
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
    if (_isSubmitting) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator(color: Colors.green)),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        context.go('/home');
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.green[50],
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text('Signaler un dépôt'),
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
                  'Remplissez ce formulaire pour signaler un dépôt sauvage',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ).animate().fade(duration: 500.ms),
                SizedBox(height: 16),

                if (!_anonymous)
                  TextFormField(
                    controller: _nameController,
                    decoration: _inputDecoration('Votre nom', Icons.person),
                    validator:
                        (val) =>
                            val == null || val.isEmpty ? 'Nom requis' : null,
                  ),
                SizedBox(height: 16),

                _useAutoLocation
                    ? TextFormField(
                      controller: TextEditingController(text: _localisation),
                      readOnly: true,
                      decoration: _inputDecoration(
                        'Localisation',
                        Icons.location_on,
                      ),
                    )
                    : Autocomplete<String>(
                      optionsBuilder: (TextEditingValue value) {
                        if (value.text == '')
                          return const Iterable<String>.empty();
                        return _availableLocations.where(
                          (option) => option.toLowerCase().contains(
                            value.text.toLowerCase(),
                          ),
                        );
                      },
                      fieldViewBuilder: (
                        context,
                        controller,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        _manualLocationController.text = controller.text;
                        return TextFormField(
                          controller: controller,
                          focusNode: focusNode,
                          decoration: _inputDecoration(
                            'Localisation (manuelle)',
                            Icons.location_on,
                          ),
                          validator:
                              (val) =>
                                  val == null || val.isEmpty
                                      ? 'Localisation requise'
                                      : null,
                        );
                      },
                      onSelected: (String selection) {
                        _manualLocationController.text = selection;
                      },
                    ),
                if (_useAutoLocation &&
                    _latitude != null &&
                    _longitude != null) ...[
                  SizedBox(height: 8),
                  Text('Latitude : $_latitude'),
                  Text('Longitude : $_longitude'),
                ],
                SizedBox(height: 16),

                TextFormField(
                  controller: _infoController,
                  decoration: _inputDecoration(
                    'Informations supplémentaires',
                    Icons.info,
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 16),

                _pickedImage == null
                    ? ElevatedButton.icon(
                      onPressed: _pickImage,
                      icon: Icon(Icons.camera_alt),
                      label: Text('Prendre une photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    )
                    : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.file(
                        _pickedImage!,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                SizedBox(height: 16),

                SwitchListTile(
                  title: Text('Je souhaite rester anonyme'),
                  value: _anonymous,
                  onChanged: (val) => setState(() => _anonymous = val),
                  activeColor: Colors.green,
                ),
                CheckboxListTile(
                  title: Text('J\'accepte les données saisies'),
                  value: _agreeData,
                  onChanged: (val) => setState(() => _agreeData = val ?? false),
                  activeColor: Colors.green,
                ),
                CheckboxListTile(
                  title: Text('Recevoir la newsletter'),
                  value: _newsletter,
                  onChanged:
                      (val) => setState(() => _newsletter = val ?? false),
                  activeColor: Colors.green,
                ),
                if (_newsletter)
                  TextFormField(
                    controller: _emailController,
                    decoration: _inputDecoration('Email', Icons.email),
                    keyboardType: TextInputType.emailAddress,
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
                  child: Text('Envoyer', style: TextStyle(fontSize: 16)),
                ).animate().slideY(begin: 0.3).fadeIn(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
