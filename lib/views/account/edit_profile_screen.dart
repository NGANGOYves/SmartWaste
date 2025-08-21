// screens/edit_profile_screen.dart
// ignore_for_file: use_build_context_synchronously, deprecated_member_use, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _adresseController = TextEditingController();
  final _telephoneController = TextEditingController();

  Position? _location;
  File? _imageFile;

  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserProvider>().user;
    _nameController.text = user?.nom ?? '';
    _adresseController.text = user?.adresse ?? '';
    _telephoneController.text = user?.telephone ?? '';
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  Future<String?> _uploadProfileImage(String userId) async {
    if (_imageFile == null) return null;
    final ref = FirebaseStorage.instance.ref('profile_images/$userId.jpg');
    await ref.putFile(_imageFile!);
    return await ref.getDownloadURL();
  }

  Future<void> _getLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) throw Exception("Localisation désactivée");

      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception("Permission refusée");
        }
      }

      final pos = await Geolocator.getCurrentPosition();
      setState(() => _location = pos);
    } catch (e) {
      print(e);
      setState(() => _error = e.toString());
    }
  }

  Future<void> _saveProfile() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Utilisateur non connecté");

      final updateData = <String, dynamic>{
        'nom': _nameController.text.trim(),
        'adresse': _adresseController.text.trim(),
        'telephone': _telephoneController.text.trim(),
      };

      if (_location != null) {
        updateData['localisation'] = jsonEncode({
          'lat': _location!.latitude,
          'lng': _location!.longitude,
        });
      }

      final photoUrl = await _uploadProfileImage(user.uid);
      if (photoUrl != null) {
        updateData['photoProfil'] = photoUrl; // champ correct ici
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set(updateData, SetOptions(merge: true));

      await context.read<UserProvider>().fetchUserData();

      context.go('/profile-view'); // back to profile
    } catch (e) {
      setState(() => _error = e.toString());
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _adresseController.dispose();
    _telephoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return WillPopScope(
      onWillPop: () async {
        context.go('/profile-view'); // this pops the current route in go_router
        return false; // prevent default system pop
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Éditer mon profil"),
          backgroundColor: const Color(0xFF28B446),
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                const SizedBox(height: 12),
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            _imageFile != null
                                ? FileImage(_imageFile!)
                                : (user?.photoProfil != null &&
                                    user!.photoProfil.isNotEmpty)
                                ? NetworkImage(user.photoProfil)
                                : const AssetImage("assets/images/user.jpg")
                                    as ImageProvider,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: const CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 18,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                _buildField("Nom complet", controller: _nameController),
                const SizedBox(height: 16),

                _buildField("Adresse", controller: _adresseController),
                const SizedBox(height: 16),

                _buildField("Téléphone", controller: _telephoneController),
                const SizedBox(height: 16),

                ElevatedButton.icon(
                  onPressed: _getLocation,
                  icon: const Icon(Icons.my_location),
                  label: const Text("Mettre à jour ma position"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28B446),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                if (_location != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Localisation: ${_location!.latitude}, ${_location!.longitude}",
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),

                if (_error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      _error!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF28B446),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child:
                      _isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sauvegarder"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label, {
    required TextEditingController controller,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
