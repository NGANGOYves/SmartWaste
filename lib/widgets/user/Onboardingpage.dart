// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:recycleapp/models/Onboardingmodel.dart';

// ==============================================================================
// ONBOARDING PAGE WIDGET
// Renders the content for a single onboarding page.
// ==============================================================================
class OnboardingPage extends StatelessWidget {
  final OnboardingPageData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image section with custom clipper for the curve
        Expanded(
          flex:
              3, // Allocate more space for the image (roughly 60% of available height)
          child: ClipPath(
            clipper: _OnboardingImageClipper(), // Apply the custom curve
            child: SizedBox(
              width: double.infinity, // Ensure image takes full width
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.cover, // Fill the space, possibly cropping
                alignment:
                    Alignment
                        .bottomCenter, // Focus on the bottom part of the image
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color:
                        Colors.grey[300], // Placeholder if image fails to load
                    child: const Center(
                      child: Text(
                        'Image Not Found',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        // Text and description section
        Expanded(
          flex:
              2, // Allocate remaining space for text and description (roughly 40%)
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Vertically center content
            children: [
              // Title of the onboarding page
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  data.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              // Description of the onboarding page
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  data.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _OnboardingImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height); // Start from top-left, go down to bottom-left
    // Create a quadratic bezier curve for the bottom edge
    // The curve dips down slightly in the middle (size.height - 40)
    path.quadraticBezierTo(
      size.width / 2,
      size.height - 40,
      size.width,
      size.height,
    );
    path.lineTo(size.width, 0); // Go up to top-right
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
