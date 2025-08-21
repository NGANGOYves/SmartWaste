import 'package:flutter/material.dart';

class CustomCaptureButton extends StatelessWidget {
  final VoidCallback onPressed;
  const CustomCaptureButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      width: 64,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
        ),
        child: const Icon(Icons.camera_alt, size: 32),
      ),
    );
  }
}
