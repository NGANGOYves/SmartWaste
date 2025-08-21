// widgets/profile_list_item.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class ProfileListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String route;

  const ProfileListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () async {
        // Show the overlay
        context.loaderOverlay.show();

        // Simulate a loading delay
        await Future.delayed(const Duration(seconds: 1));

        // Hide the overlay
        if (context.mounted) {
          context.loaderOverlay.hide();

          // Navigate or do something after loading
          context.go(route);
        }
      },
    );
  }
}
