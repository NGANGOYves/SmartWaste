import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

class MenuCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final String route; // Route name/path

  const MenuCard({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
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
      borderRadius: BorderRadius.circular(12),
      child: Material(
        elevation: 4, // Add elevation here
        borderRadius: BorderRadius.circular(12),
        color: Colors.white, // Background color of the card
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color, size: 30),
                const SizedBox(height: 10),
                Text(label, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
