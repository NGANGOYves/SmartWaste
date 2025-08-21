// complete_profile_page.dart

// ignore_for_file: use_build_context_synchronously, file_names

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
import 'package:shared_preferences/shared_preferences.dart';

class CompleteProfilePage extends StatefulWidget {
  const CompleteProfilePage({super.key});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  final _phoneController = TextEditingController();
  final _adresseController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;
  Position? _location;
  File? _pickedImage;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _phoneController.dispose();
    _adresseController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur lors de la sélection de l'image: $e";
      });
    }
  }

  Future<String?> _uploadProfileImage(File imageFile, String uid) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('$uid.jpg');

      await ref.putFile(imageFile);
      return await ref.getDownloadURL();
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur lors du téléchargement de l'image: $e";
      });
      return null;
    }
  }

  Future<void> _getLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = "Service de localisation désactivé.";
        });
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          setState(() {
            _errorMessage = "Permission de localisation refusée.";
          });
          return;
        }
      }

      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _location = pos;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur localisation: $e";
      });
    }
  }

  Future<void> _submitProfile() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception("Utilisateur non connecté");

      String? photoUrl = user.photoURL;

      if (_pickedImage != null) {
        final uploadedUrl = await _uploadProfileImage(_pickedImage!, user.uid);
        if (uploadedUrl != null) {
          photoUrl = uploadedUrl;
        }
      }

      final updateData = {
        'telephone': _phoneController.text.trim(),
        'adresse': _adresseController.text.trim(),
        'photoProfil': photoUrl ?? '',
      };

      if (_location != null) {
        updateData['localisation'] = jsonEncode({
          'lat': _location!.latitude,
          'lng': _location!.longitude,
        });
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update(updateData);

      // Update provider too
      await context.read<UserProvider>().fetchUserData();
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("user_id", user.uid);
      await prefs.setString("user_nom", user.displayName ?? user.uid);
      await prefs.setString("user_email", user.email ?? '');
      await prefs.setString("user_photo", photoUrl ?? '');
      await prefs.setString("user_adresse", _adresseController.text.trim());
      await prefs.setString("user_telephone", _phoneController.text.trim());

      if (_location != null) {
        await prefs.setString(
          "user_location",
          jsonEncode({'lat': _location!.latitude, 'lng': _location!.longitude}),
        );
      }

      context.go('/home');
    } catch (e) {
      setState(() {
        _errorMessage = "Erreur: ${e.toString()}";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final photoUrl =
        _pickedImage != null
            ? FileImage(_pickedImage!)
            : (user?.photoProfil != null && user!.photoProfil.isNotEmpty)
            ? NetworkImage(user.photoProfil)
            : const AssetImage('assets/images/avatar_placeholder.png')
                as ImageProvider;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 24),

              // Profile photo with edit icon
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: photoUrl,
                      backgroundColor: Colors.grey[200],
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF28B446),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          padding: const EdgeInsets.all(8),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                "Bonjour, ${user?.nom ?? 'utilisateur'} 👋",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF28B446),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Complétez votre profil pour continuer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),

              const SizedBox(height: 32),

              // Readonly email and name fields
              _readonlyField("Email", user?.email ?? ''),
              const SizedBox(height: 16),
              _readonlyField("Nom", user?.nom ?? ''),
              const SizedBox(height: 32),

              // Editable phone & address fields
              _buildTextField(
                "Téléphone",
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: Icons.phone,
              ),
              const SizedBox(height: 24),
              _buildTextField(
                "Adresse",
                controller: _adresseController,
                prefixIcon: Icons.location_on,
              ),

              const SizedBox(height: 24),

              ElevatedButton.icon(
                onPressed: _getLocation,
                icon: const Icon(Icons.my_location),
                label: const Text("Localiser automatiquement"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B446),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              if (_location != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    "Localisation capturée ✅ (${_location!.latitude.toStringAsFixed(5)}, ${_location!.longitude.toStringAsFixed(5)})",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.green),
                  ),
                ),

              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text(
                    _errorMessage!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 36),

              ElevatedButton(
                onPressed: _isLoading ? null : _submitProfile,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B446),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    _isLoading
                        ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(color: Colors.white),
                        )
                        : const Text(
                          "Terminer",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _readonlyField(String label, String value) {
    return TextField(
      enabled: false,
      controller: TextEditingController(text: value),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
      style: const TextStyle(color: Colors.black87, fontSize: 16),
    );
  }

  Widget _buildTextField(
    String hint, {
    TextEditingController? controller,
    TextInputType? keyboardType,
    IconData? prefixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon:
            prefixIcon != null ? Icon(prefixIcon, color: Colors.grey) : null,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 18,
          horizontal: 16,
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
