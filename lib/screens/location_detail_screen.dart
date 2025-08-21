// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/location_model.dart';
import 'search_screen.dart';
import 'package:geolocator/geolocator.dart';

class LocationDetailScreen extends StatefulWidget {
  final Location location;

  const LocationDetailScreen({super.key, required this.location});

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  List<Location> nearbyLocations = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadNearbyLocations();
  }

  Future<double> getDistanceToUser(LatLng pointLatLng) async {
    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    final double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      pointLatLng.latitude,
      pointLatLng.longitude,
    );

    return distanceInMeters / 1000; // en kilomètres
  }

  Future<void> _loadNearbyLocations() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance
              .collection('points_de_rammassage')
              .get();

      final List<Location> allLocations = [];

      for (var doc in snapshot.docs) {
        try {
          final location = Location.fromFirestore(doc);
          final double distanceToUser = await getDistanceToUser(
            location.latLng,
          );

          final updatedLocation = location.copyWith(
            distance: '${distanceToUser.toStringAsFixed(1)} km',
          );

          allLocations.add(updatedLocation);
        } catch (e) {
          debugPrint('Erreur lors du traitement du point : $e');
        }
      }

      if (!mounted) return; // ✅ check before calling setState
      setState(() {
        nearbyLocations = allLocations;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Erreur lors du chargement : $e');
      if (!mounted) return; // ✅ check here too
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed:
              () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              ),
          icon: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                child: Column(
                  children: [
                    Image.network(
                      widget.location.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                      errorBuilder:
                          (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 48),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.location.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  widget.location.distance,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "Information sur ${widget.location.name}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.blue,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.green,
                                ),
                                const SizedBox(width: 8),
                                Text(widget.location.openTime),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.attach_money,
                            //       color: Colors.orange,
                            //     ),
                            //     const SizedBox(width: 8),
                            //     Text(widget.location.price),
                            //   ],
                            // ),
                            const SizedBox(height: 12),
                            Text(widget.location.description),
                            const SizedBox(height: 20),
                            if (nearbyLocations.isNotEmpty) ...[
                              const Text(
                                "Points de ramassage proches",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...nearbyLocations.map(
                                (loc) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(
                                        context,
                                        rootNavigator: true,
                                      ).push(
                                        MaterialPageRoute(
                                          builder:
                                              (_) => LocationDetailScreen(
                                                location: loc,
                                              ),
                                        ),
                                      );
                                    },
                                    child: _buildNearbyCard(loc),
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(height: 80),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _buildNearbyCard(Location loc) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(12),
            ),
            child: Image.network(
              loc.imageUrl,
              height: 100,
              width: 100,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => Container(
                    height: 100,
                    width: 100,
                    color: Colors.grey.shade200,
                    child: const Icon(Icons.broken_image),
                  ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc.distance,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),
                  Text(loc.description, style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
