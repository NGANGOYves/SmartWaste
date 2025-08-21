// // ignore_for_file: file_names, unused_field, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;

//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signInWithEmail() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = "Veuillez remplir tous les champs.";
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       await _auth.signInWithEmailAndPassword(email: email, password: password);
//       context.go('/home');
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message ?? 'Erreur inconnue';
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
//                 child: IconButton(
//                   icon: const Icon(Icons.arrow_back, size: 28),
//                   onPressed: () => context.go('/welcome'),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               const Text(
//                 "Bon retour ! Heureux de vous revoir !",
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.w600,
//                   color: Color(0xFF28B446),
//                 ),
//               ),
//               const SizedBox(height: 32),
//               _buildTextField(
//                 "Entrez votre email",
//                 controller: _emailController,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(
//                 "Entrez votre mot de passe",
//                 obscureText: true,
//                 controller: _passwordController,
//               ),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: TextButton(
//                   onPressed: () => context.go('/forgot'),
//                   child: const Text(
//                     "Mot de passe oublié ?",
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                 ),
//               ),
//               if (_errorMessage != null)
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 12.0),
//                   child: Text(
//                     _errorMessage!,
//                     style: const TextStyle(color: Colors.red),
//                   ),
//                 ),
//               ElevatedButton(
//                 onPressed: _isLoading ? null : _signInWithEmail,
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
//                           "Se connecter",
//                           style: TextStyle(fontSize: 16),
//                         ),
//               ),
//               const SizedBox(height: 24),
//               Row(
//                 children: const [
//                   Expanded(child: Divider(thickness: 1)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Text(
//                       "Ou connectez-vous avec",
//                       style: TextStyle(fontSize: 14, color: Colors.black54),
//                     ),
//                   ),
//                   Expanded(child: Divider(thickness: 1)),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // _buildSocialButton(FontAwesomeIcons.facebookF, onPressed: () {
//                   //   ScaffoldMessenger.of(context).showSnackBar(
//                   //     const SnackBar(content: Text("Connexion Facebook non implémentée")),
//                   //   );
//                   // }),
//                   //const SizedBox(width: 20),
//                   _buildSocialButton(
//                     FontAwesomeIcons.google,
//                     onPressed: _isLoading ? null : _signInWithGoogle,
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Center(
//                 child: TextButton(
//                   onPressed: () => context.go('/register'),
//                   child: const Text.rich(
//                     TextSpan(
//                       text: "Vous n'avez pas de compte ? ",
//                       children: [
//                         TextSpan(
//                           text: "Inscrivez-vous maintenant",
//                           style: TextStyle(
//                             color: Color(0xFF28B446),
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ],
//                       style: TextStyle(color: Colors.black54),
//                     ),
//                   ),
//                 ),
//               ),
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
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//         suffixIcon:
//             obscureText
//                 ? const Icon(Icons.remove_red_eye_outlined, color: Colors.grey)
//                 : null,
//       ),
//     );
//   }

//   Widget _buildSocialButton(IconData icon, {VoidCallback? onPressed}) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: IconButton(
//         icon: FaIcon(icon, size: 24, color: Colors.black),
//         onPressed: onPressed,
//       ),
//     );
//   }
// }

// ignore_for_file: file_names, unused_field, use_build_context_synchronously, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:recycleapp/services/user_provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;

//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signInWithEmail() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = "Veuillez remplir tous les champs.";
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       // ignore: unused_local_variable
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       // ✅ Load user profile to provider
//       await context.read<UserProvider>().fetchUserData();
//       final user = userCredential.user;

//       await checkUserProfileCompletionAndNavigate(context, user!);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message ?? 'Erreur inconnue';
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

//         // ✅ Load user profile to provider
//         await context.read<UserProvider>().fetchUserData();

//         await checkUserProfileCompletionAndNavigate(context, user);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Erreur Google Sign-In: $e";
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   /////////
//   Future<void> checkUserProfileCompletionAndNavigate(
//     BuildContext context,
//     User user,
//   ) async {
//     final doc =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();
//     final data = doc.data();

//     final phone = data?['telephone'] ?? '';
//     final address = data?['adresse'] ?? '';

//     if (phone.isEmpty || address.isEmpty) {
//       // Not complete -> Complete profile
//       context.go('/complete-profile');
//     } else {
//       // Profile complete -> Home
//       context.go('/home');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         context.go('/welcome'); // this pops the current route in go_router
//         return false; // prevent default system pop
//       },
//       child: Scaffold(
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0),
//             child: ListView(
//               children: [
//                 const SizedBox(height: 16),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: IconButton(
//                     icon: const Icon(Icons.arrow_back, size: 28),
//                     onPressed: () => context.go('/welcome'),
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 const Text(
//                   "Bon retour ! Heureux de vous revoir !",
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.w600,
//                     color: Color(0xFF28B446),
//                   ),
//                 ),
//                 const SizedBox(height: 32),
//                 _buildTextField(
//                   "Entrez votre email",
//                   controller: _emailController,
//                 ),
//                 const SizedBox(height: 16),
//                 _buildTextField(
//                   "Entrez votre mot de passe",
//                   obscureText: true,
//                   controller: _passwordController,
//                 ),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: TextButton(
//                     onPressed: () => context.go('/forgot'),
//                     child: const Text(
//                       "Mot de passe oublié ?",
//                       style: TextStyle(fontSize: 14, color: Colors.black54),
//                     ),
//                   ),
//                 ),
//                 if (_errorMessage != null)
//                   Padding(
//                     padding: const EdgeInsets.only(bottom: 12.0),
//                     child: Text(
//                       _errorMessage!,
//                       style: const TextStyle(color: Colors.red),
//                     ),
//                   ),
//                 ElevatedButton(
//                   onPressed: _isLoading ? null : _signInWithEmail,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFF28B446),
//                     foregroundColor: Colors.white,
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     elevation: 0,
//                   ),
//                   child:
//                       _isLoading
//                           ? const CircularProgressIndicator(color: Colors.white)
//                           : const Text(
//                             "Se connecter",
//                             style: TextStyle(fontSize: 16),
//                           ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   children: const [
//                     Expanded(child: Divider(thickness: 1)),
//                     Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0),
//                       child: Text(
//                         "Ou connectez-vous avec",
//                         style: TextStyle(fontSize: 14, color: Colors.black54),
//                       ),
//                     ),
//                     Expanded(child: Divider(thickness: 1)),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     _buildSocialButton(
//                       SvgPicture.asset(
//                         'assets/icon/google_icon.svg',
//                         height: 34,
//                         width: 34,
//                       ),
//                       onPressed: _isLoading ? null : _signInWithGoogle,
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 Center(
//                   child: TextButton(
//                     onPressed: () => context.go('/register'),
//                     child: const Text.rich(
//                       TextSpan(
//                         text: "Vous n'avez pas de compte ? ",
//                         children: [
//                           TextSpan(
//                             text: "Inscrivez-vous maintenant",
//                             style: TextStyle(
//                               color: Color(0xFF28B446),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
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
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//         suffixIcon:
//             obscureText
//                 ? const Icon(Icons.remove_red_eye_outlined, color: Colors.grey)
//                 : null,
//       ),
//     );
//   }

//   Widget _buildSocialButton(Widget icon, {VoidCallback? onPressed}) {
//     return Container(
//       width: 80,
//       height: 80,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: IconButton(icon: icon, onPressed: onPressed),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:go_router/go_router.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:provider/provider.dart';
// import 'package:recycleapp/services/user_provider.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _firestore = FirebaseFirestore.instance;

//   bool _isLoading = false;
//   String? _errorMessage;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signInWithEmail() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });

//     final email = _emailController.text.trim();
//     final password = _passwordController.text.trim();

//     if (email.isEmpty || password.isEmpty) {
//       setState(() {
//         _errorMessage = "Veuillez remplir tous les champs.";
//         _isLoading = false;
//       });
//       return;
//     }

//     try {
//       final userCredential = await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );

//       await context.read<UserProvider>().fetchUserData();
//       final user = userCredential.user;

//       await checkUserProfileCompletionAndNavigate(context, user!);
//     } on FirebaseAuthException catch (e) {
//       setState(() {
//         _errorMessage = e.message ?? 'Erreur inconnue';
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

//         await context.read<UserProvider>().fetchUserData();
//         await checkUserProfileCompletionAndNavigate(context, user);
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = "Erreur Google Sign-In: $e";
//       });
//     } finally {
//       setState(() => _isLoading = false);
//     }
//   }

//   Future<void> checkUserProfileCompletionAndNavigate(
//     BuildContext context,
//     User user,
//   ) async {
//     final doc =
//         await FirebaseFirestore.instance
//             .collection('users')
//             .doc(user.uid)
//             .get();

//     final data = doc.data();
//     final phone = data?['telephone'] ?? '';
//     final address = data?['adresse'] ?? '';

//     if (phone.isEmpty || address.isEmpty) {
//       context.go('/complete-profile');
//     } else {
//       context.go('/home');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: WillPopScope(
//         onWillPop: () async {
//           context.go('/welcome');
//           return false;
//         },
//         child: SafeArea(
//           child: Center(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 16),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: IconButton(
//                       icon: const Icon(Icons.arrow_back, size: 28),
//                       onPressed: () => context.go('/welcome'),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   Image.asset(
//                     'assets/images/login_illustration.png', // Optional friendly image
//                     height: 150,
//                     width: 200,
//                   ),
//                   const SizedBox(height: 16),
//                   const Text(
//                     "Bon retour ! 👋",
//                     style: TextStyle(
//                       fontSize: 26,
//                       fontWeight: FontWeight.w700,
//                       color: Color(0xFF28B446),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Heureux de vous revoir ! Connectez-vous à votre compte",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 14, color: Colors.black54),
//                   ),
//                   const SizedBox(height: 32),
//                   _buildTextField(
//                     "Entrez votre email",
//                     controller: _emailController,
//                   ),
//                   const SizedBox(height: 16),
//                   _buildTextField(
//                     "Entrez votre mot de passe",
//                     obscureText: true,
//                     controller: _passwordController,
//                   ),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () => context.go('/forgot'),
//                       child: const Text(
//                         "Mot de passe oublié ?",
//                         style: TextStyle(fontSize: 14, color: Colors.black54),
//                       ),
//                     ),
//                   ),
//                   if (_errorMessage != null)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 12.0),
//                       child: Text(
//                         _errorMessage!,
//                         style: const TextStyle(color: Colors.red),
//                       ),
//                     ),
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _signInWithEmail,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF28B446),
//                       foregroundColor: Colors.white,
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       elevation: 1,
//                     ),
//                     child:
//                         _isLoading
//                             ? const SizedBox(
//                               height: 20,
//                               width: 20,
//                               child: CircularProgressIndicator(
//                                 color: Colors.white,
//                               ),
//                             )
//                             : const Text(
//                               "Se connecter",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                   ),
//                   const SizedBox(height: 24),
//                   Row(
//                     children: const [
//                       Expanded(child: Divider(thickness: 1)),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 8.0),
//                         child: Text(
//                           "Ou connectez-vous avec",
//                           style: TextStyle(fontSize: 14, color: Colors.black54),
//                         ),
//                       ),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),
//                   const SizedBox(height: 16),
//                   _buildSocialButton(
//                     SvgPicture.asset(
//                       'assets/icon/google_icon.svg',
//                       height: 30,
//                       width: 30,
//                     ),
//                     onPressed: _isLoading ? null : _signInWithGoogle,
//                   ),
//                   const SizedBox(height: 32),
//                   TextButton(
//                     onPressed: () => context.go('/register'),
//                     child: const Text.rich(
//                       TextSpan(
//                         text: "Vous n'avez pas de compte ? ",
//                         children: [
//                           TextSpan(
//                             text: "Inscrivez-vous maintenant",
//                             style: TextStyle(
//                               color: Color(0xFF28B446),
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ],
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
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
//       decoration: InputDecoration(
//         hintText: hint,
//         hintStyle: const TextStyle(color: Colors.grey),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(10),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: Colors.grey[100],
//         suffixIcon:
//             obscureText
//                 ? const Icon(Icons.remove_red_eye_outlined, color: Colors.grey)
//                 : null,
//       ),
//     );
//   }

//   Widget _buildSocialButton(Widget icon, {VoidCallback? onPressed}) {
//     return Container(
//       width: 60,
//       height: 60,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.grey.shade300),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: IconButton(icon: icon, onPressed: onPressed),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithEmail() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = "Veuillez remplir tous les champs.";
        _isLoading = false;
      });
      return;
    }

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await context.read<UserProvider>().fetchUserData();
      final user = userCredential.user;

      await checkUserProfileCompletionAndNavigate(context, user!);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = "Adresse email invalide.";
          break;
        case 'user-disabled':
          message = "Ce compte a été désactivé.";
          break;
        case 'user-not-found':
          message = "Aucun compte n’est associé à cet email.";
          break;
        case 'wrong-password':
          message = "Mot de passe incorrect.";
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: WillPopScope(
        onWillPop: () async {
          context.go('/welcome');
          return false;
        },
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 28),
                      onPressed: () => context.go('/welcome'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 160,
                    child: Image.asset(
                      'assets/images/login_illustration.png',
                      fit:
                          BoxFit
                              .cover, // or use BoxFit.fitWidth for better proportion
                    ),
                  ),
                  const SizedBox(height: 16),
                  // const Text(
                  //   "Bon retour 👋",
                  //   style: TextStyle(
                  //     fontSize: 28,
                  //     fontWeight: FontWeight.bold,
                  //     color: Color(0xFF28B446),
                  //   ),
                  // ),
                  const SizedBox(height: 8),
                  const Text(
                    "Connectez-vous à votre compte pour continuer",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                  const SizedBox(height: 32),

                  // Email Field
                  _buildTextField(
                    hint: "Email",
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 16),

                  // Password Field
                  _buildTextField(
                    hint: "Mot de passe",
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    obscureText: true,
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => context.go('/forgot'),
                      child: const Text(
                        "Mot de passe oublié ?",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),

                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),

                  ElevatedButton(
                    onPressed: _isLoading ? null : _signInWithEmail,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF28B446),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 52),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child:
                        _isLoading
                            ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Text(
                              "Se connecter",
                              style: TextStyle(fontSize: 16),
                            ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: const [
                      Expanded(child: Divider()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          "Ou connectez-vous avec",
                          style: TextStyle(fontSize: 13, color: Colors.black45),
                        ),
                      ),
                      Expanded(child: Divider()),
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
                  const SizedBox(height: 28),

                  TextButton(
                    onPressed: () => context.go('/register'),
                    child: const Text.rich(
                      TextSpan(
                        text: "Vous n'avez pas de compte ? ",
                        children: [
                          TextSpan(
                            text: "Créer un compte",
                            style: TextStyle(
                              color: Color(0xFF28B446),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required IconData icon,
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
