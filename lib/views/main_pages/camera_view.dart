import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:recycleapp/theme.dart';
import 'package:recycleapp/views/signal/Hors_abonne/recyle_form_view.dart';

class CustomCameraView extends StatefulWidget {
  const CustomCameraView({super.key});

  @override
  State<CustomCameraView> createState() => _CustomCameraViewState();
}

class _CustomCameraViewState extends State<CustomCameraView> {
  late CameraController _controller;
  bool _isCameraReady = false;
  bool _isFlashOn = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    context.loaderOverlay.show(); // Show loading overlay

    try {
      final cameras = await availableCameras();
      final camera = cameras.first;

      _controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _controller.initialize();

      if (!mounted) return;
      setState(() => _isCameraReady = true);
    } catch (e) {
      debugPrint('Camera error: $e');
    } finally {
      if (mounted) context.loaderOverlay.hide(); // Hide overlay
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    setState(() => _isFlashOn = !_isFlashOn);
    await _controller.setFlashMode(
      _isFlashOn ? FlashMode.torch : FlashMode.off,
    );
  }

  Future<void> _takePicture() async {
    try {
      final image = await _controller.takePicture();
      debugPrint('Image path: ${image.path}');
      final file = File(image.path);

      // Navigate to the form page passing the picture
      if (mounted) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RecycleFormPage(initialImage: file),
          ),
        );
      }
    } catch (e) {
      debugPrint('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:
          !_isCameraReady
              ? const SizedBox.shrink()
              : Stack(
                fit: StackFit.expand,
                children: [
                  CameraPreview(_controller),

                  // Back button (top-left)
                  Positioned(
                    top: 40,
                    left: 20,
                    child: SafeArea(
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),

                  // Flash and capture buttons (bottom center)
                  Positioned(
                    bottom: 60,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: _toggleFlash,
                          icon: Icon(
                            _isFlashOn ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        GestureDetector(
                          onTap: _takePicture,
                          child: Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primary,
                                width: 4,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 48), // Space for symmetry
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}
