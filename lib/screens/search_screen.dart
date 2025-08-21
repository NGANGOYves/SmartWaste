import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/location_model.dart';
import 'location_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();

  List<Location> _allLocations = [];
  List<Location> _filteredLocations = [];
  final Set<Marker> _markers = {};
  bool _isLoading = true;

  static const LatLng _initialPosition = LatLng(3.8667, 11.5167); // Yaoundé

  @override
  void initState() {
    super.initState();
    _fetchLocations();
  }

  Future<void> _fetchLocations() async {
    final snapshot = await FirebaseFirestore.instance.collection('points_de_rammassage').get();
    final locations = snapshot.docs.map((doc) => Location.fromFirestore(doc)).toList();

    setState(() {
      _allLocations = locations;
      _addMarkers();
      _isLoading = false;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _addMarkers() {
    _markers.clear();
    for (var loc in _allLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId(loc.name),
          position: loc.latLng,
          infoWindow: InfoWindow(title: loc.name),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => LocationDetailScreen(location: loc),
              ),
            );
          },
        ),
      );
    }
    setState(() {});
  }

  void _onSearchChanged(String query) {
    setState(() {
      _filteredLocations = _allLocations
          .where((loc) => loc.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectLocation(Location loc) {
    _mapController.animateCamera(CameraUpdate.newLatLngZoom(loc.latLng, 14));
    _searchController.text = loc.name;
    _filteredLocations = [];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => LocationDetailScreen(location: loc)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: const CameraPosition(
                target: _initialPosition,
                zoom: 10,
              ),
              markers: _markers,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
            ),
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Material(
                  elevation: 4,
                  borderRadius: BorderRadius.circular(8),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Search location...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                if (_filteredLocations.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 4),
                      ],
                    ),
                    child: Column(
                      children: _filteredLocations
                          .map(
                            (loc) => ListTile(
                              title: Text(loc.name),
                              onTap: () => _selectLocation(loc),
                            ),
                          )
                          .toList(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
