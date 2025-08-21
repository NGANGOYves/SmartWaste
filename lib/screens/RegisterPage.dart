// // ignore_for_file: file_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({super.key});

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   final _auth = FirebaseAuth.instance;
//   final _firestore = FirebaseFirestore.instance;

//   final _usernameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   Future<void> _registerWithEmail() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final username = _usernameController.text.trim();
//     final email = _emailController.text.trim();
//     final password = _passwordController.text;
//     final confirmPassword = _confirmPasswordController.text;

//     if (username.isEmpty ||
//         email.isEmpty ||
//         password.isEmpty ||
//         confirmPassword.isEmpty) {
//       setState(() {
//         _errorMessage = "Veuillez remplir tous les champs.";
//         _isLoading = false;
//       });
//       return;
//     }

//     if (password != confirmPassword) {
//       setState(() {
//         _errorMessage = "Les mots de passe ne correspondent pas.";
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       final userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       final user = userCredential.user;

//       if (user != null) {
//         await _firestore.collection('users').doc(user.uid).set({
//           'nom': username,
//           'email': email,
//           'telephone': '',
//           'adresse': '',
//           'photoProfil': '',
//           'createdAt': FieldValue.serverTimestamp(),
//         });
//         context.go('/home');
//       }
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message ?? 'Erreur inconnue.';
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> _signInWithGoogle() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     try {
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
//       if (googleUser == null) {
//         setState(() => _isLoading = false);
//         return;
//       }

//       final googleAuth = await googleUser.authentication;

//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       final userCredential = await _auth.signInWithCredential(credential);
//       final user = userCredential.user;

//       if (user != null) {
//         final docRef = _firestore.collection('users').doc(user.uid);
//         final doc = await docRef.get();

//         if (!doc.exists) {
//           await docRef.set({
//             'nom': user.displayName ?? '',
//             'email': user.email ?? '',
//             'telephone': '',
//             'adresse': '',
//             'photoProfil': user.photoURL ?? '',
//             'createdAt': FieldValue.serverTimestamp(),
//           });
//         }

//         context.go('/home');
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Erreur Google Sign-In: $e";
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: ListView(
//             children: [
//               const SizedBox(height: 16),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade300),
//                     shape: BoxShape.circle,
//                   ),
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back),
//                     onPressed: () => Navigator.pop(context),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               const Text(
//                 "Bonjour ! Inscrivez-vous pour commencer",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w700,
//                   color: Color(0xFF28B446),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildTextField(
//                 "Nom d'utilisateur",
//                 controller: _usernameController,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField("Email", controller: _emailController),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Mot de passe",
//                 obscureText: true,
//                 controller: _passwordController,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Confirmer le mot de passe",
//                 obscureText: true,
//                 controller: _confirmPasswordController,
//               ),
//               if (_errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(top: 12.0),
//                   child: Text(
//                     _errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//               const SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _registerWithEmail,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF28B446),
//                   foregroundColor: Colors.white,
//                   minimumSize: const Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   elevation: 0,
//                 ),
//                 child:
//                     _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text(
//                           "S'inscrire",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//               ),
//               const SizedBox(height: 32),
//               Row(
//                 children: const [
//                   Expanded(child: Divider(thickness: 1)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       "Ou s'inscrire avec",
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ),
//                   Expanded(child: Divider(thickness: 1)),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // _buildSocialButton(FontAwesomeIcons.facebookF, () {
//                   //   ScaffoldMessenger.of(context).showSnackBar(
//                   //     const SnackBar(content: Text("Connexion Facebook non implémentée")),
//                   //   );
//                   // }),
//                   //const SizedBox(width: 20),
//                   _buildSocialButton(
//                     FontAwesomeIcons.google,
//                     _isLoading ? null : _signInWithGoogle,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Center(
//                 child: TextButton(
//                   onPressed: () => context.go('/login'),
//                   child: RichText(
//                     text: const TextSpan(
//                       text: "Vous avez déjà un compte ? ",
//                       style: TextStyle(color: Colors.black87),
//                       children: [
//                         TextSpan(
//                           text: "Connectez-vous",
//                           style: TextStyle(
//                             color: Color(0xFF28B446),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 8),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(
//     String hint, {
//     bool obscureText = false,
//     TextEditingController? controller,
//   }) {
//     return TextField(
//       controller: controller,
//       obscureText: obscureText,
//       style: const TextStyle(fontSize: 14),
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 18,
//           horizontal: 16,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//       ),
//     );
//   }

//   Widget _buildSocialButton(IconData icon, VoidCallback? onTap) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: IconButton(
//         icon: FaIcon(icon, size: 24, color: Colors.black),
//         onPressed: onTap,
//       ),
//     );
//   }
// }

// ignore_for_file: file_names, use_build_context_synchronously, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerWithEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final username = _usernameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      setState(() {
        _errorMessage = "Veuillez remplir tous les champs.";
        _isLoading = false;
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorMessage = "Les mots de passe ne correspondent pas.";
        _isLoading = false;
      });
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'nom': username,
          'email': email,
          'telephone': '',
          'adresse': '',
          'photoProfil': '',
          'createdAt': FieldValue.serverTimestamp(),
        });

        await context.read<UserProvider>().fetchUserData();
        await checkUserProfileCompletionAndNavigate(context, user);
      }
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'email-already-in-use':
          message = "Cet email est déjà utilisé.";
          break;
        case 'invalid-email':
          message = "Adresse email invalide.";
          break;
        case 'operation-not-allowed':
          message = "Cette opération n’est pas autorisée.";
          break;
        case 'weak-password':
          message =
              "Mot de passe trop faible. Veuillez en choisir un plus sécurisé.";
          break;
        default:
          message = "Une erreur s’est produite. Veuillez réessayer.";
      }
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            "Une erreur inattendue s’est produite. Veuillez réessayer.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => _isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final docRef = _firestore.collection('users').doc(user.uid);
        final doc = await docRef.get();

        if (!doc.exists) {
          await docRef.set({
            'nom': user.displayName ?? '',
            'email': user.email ?? '',
            'telephone': '',
            'adresse': '',
            'photoProfil': user.photoURL ?? '',
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        await context.read<UserProvider>().fetchUserData();
        await checkUserProfileCompletionAndNavigate(context, user);
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      String message = "Connexion Google échouée. Veuillez réessayer.";
      setState(() {
        _errorMessage = message;
      });
    } catch (e) {
      setState(() {
        _errorMessage =
            "Une erreur inattendue s’est produite lors de la connexion Google.";
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> checkUserProfileCompletionAndNavigate(
    BuildContext context,
    User user,
  ) async {
    final doc =
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
    final data = doc.data();

    final phone = data?['telephone'] ?? '';
    final address = data?['adresse'] ?? '';

    if (phone.isEmpty || address.isEmpty) {
      context.go('/complete-profile');
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.go('/welcome');
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => context.go('/welcome'),
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  "Créer un compte",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Veuillez renseigner vos informations pour commencer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              _buildTextField(
                "Nom d'utilisateur",
                controller: _usernameController,
              ),
              const SizedBox(height: 16),
              _buildTextField("Adresse Email", controller: _emailController),
              const SizedBox(height: 16),
              _buildTextField(
                "Mot de passe",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                "Confirmer le mot de passe",
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _registerWithEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:
                    _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          "S'inscrire",
                          style: TextStyle(fontSize: 16),
                        ),
              ),
              const SizedBox(height: 28),
              Row(
                children: const [
                  Expanded(child: Divider(thickness: 1)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      "Ou continuez avec",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  Expanded(child: Divider(thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),
              _buildSocialButton(
                SvgPicture.asset(
                  'assets/icon/google_icon.svg',
                  height: 28,
                  width: 28,
                ),
                onPressed: _isLoading ? null : _signInWithGoogle,
              ),
              const SizedBox(height: 32),
              Center(
                child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text.rich(
                    TextSpan(
                      text: "Déjà un compte ? ",
                      children: [
                        TextSpan(
                          text: "Se connecter",
                          style: TextStyle(
                            color: Color(0xFF28B446),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String hint, {
    bool obscureText = false,
    TextEditingController? controller,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.green, // Change to your theme color
            width: 1.5,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }

  Widget _buildSocialButton(Widget icon, {VoidCallback? onPressed}) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: icon,
      ),
    );
  }
}
