import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recycleapp/services/user_provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    final String name = user?.nom ?? "Utilisateur";
    final String email = user?.email ?? "user@smartwaste.com";
    final String? photoUrl = user?.photoProfil;
    final String ecoPoints = user?.ecoPoints ?? '0';

    return Column(
      children: [
        CircleAvatar(
          radius: 45,
          backgroundImage:
              photoUrl != null && photoUrl.isNotEmpty
                  ? NetworkImage(photoUrl)
                  : const AssetImage("assets/images/user.jpg") as ImageProvider,
        ),
        const SizedBox(height: 10),
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        Text(email, style: const TextStyle(color: Colors.grey)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.eco, color: Colors.green),
            const SizedBox(width: 4),
            Text(
              "$ecoPoints Eco Points",
              style: const TextStyle(color: Colors.green),
            ),
          ],
        ),
      ],
    );
  }
}
