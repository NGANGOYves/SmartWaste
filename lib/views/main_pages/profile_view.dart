// // screens/profile_screen.dart
// import 'package:flutter/material.dart';
// import '../../widgets/user/profile_header.dart';
// import '../../widgets/user/profile_list_item.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: Column(
//             children: [
//               const SizedBox(height: 24),
//               const ProfileHeader(),
//               const SizedBox(height: 24),
//               const Divider(),
//               const ProfileListItem(
//                 icon: Icons.person,
//                 title: "À propos de moi", // About me
//                 route: "/about-me",
//               ),

//               const ProfileListItem(
//                 icon: Icons.notifications,
//                 title: "Notifications", // Notifications (unchanged)
//                 route: "/notif-view",
//               ),
//               const Divider(),
//               const ProfileListItem(
//                 icon: Icons.info,
//                 title: "Version", // Version (unchanged)
//                 route: "/app-version",
//               ),
//               ProfileListItem(
//                 icon: Icons.logout,
//                 title: "Déconnexion", // Sign out
//                 route: "/",
//               ),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// ignore_for_file: unused_local_variable

// profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/user_provider.dart';
import '../../widgets/user/profile_header.dart';
import '../../widgets/user/profile_list_item.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 24),
              ProfileHeader(),
              const SizedBox(height: 24),
              const Divider(),
              const ProfileListItem(
                icon: Icons.person,
                title: "À propos de moi",
                route: "/edit-profile",
              ),
              const ProfileListItem(
                icon: Icons.notifications,
                title: "Notifications",
                route: "/notif-view",
              ),
              const Divider(),
              const ProfileListItem(
                icon: Icons.info,
                title: "Version",
                route: "/app-version",
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  await context.read<UserProvider>().logoutAndClearPrefs(
                    context,
                  );
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text("Déconnexion"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF28B446),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: const TextStyle(
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
}
