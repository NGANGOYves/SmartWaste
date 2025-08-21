import 'package:flutter/material.dart';

class BottomConvexClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);

    // Convex curve: highest at sides, lowest at center
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 120, // dip in center
      size.width,
      size.height - 50,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
