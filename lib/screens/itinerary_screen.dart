import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ItineraryScreen extends StatefulWidget {
  static const routeName = '/itinerary';
  final LatLng startLocation;
  final LatLng endLocation;

  const ItineraryScreen({
    super.key,
    required this.startLocation,
    required this.endLocation,
  });

  @override
  State<ItineraryScreen> createState() => _ItineraryScreenState();
}

class _ItineraryScreenState extends State<ItineraryScreen> {
  // late GoogleMapController _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _initMarkersAndRoute();
  }

  void _initMarkersAndRoute() {
    _markers = {
      Marker(
        markerId: MarkerId("start"),
        position: widget.startLocation,
        infoWindow: InfoWindow(title: "Start"),
      ),
      Marker(
        markerId: MarkerId("end"),
        position: widget.endLocation,
        infoWindow: InfoWindow(title: "Destination"),
      ),
    };

    _polylines = {
      Polyline(
        polylineId: PolylineId("route"),
        points: [widget.startLocation, widget.endLocation],
        color: Colors.red,
        width: 5,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final LatLng center = LatLng(
      (widget.startLocation.latitude + widget.endLocation.latitude) / 2,
      (widget.startLocation.longitude + widget.endLocation.longitude) / 2,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Itinerary"),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: center, zoom: 9),
        // onMapCreated: (controller) => _mapController = controller,
        markers: _markers,
        polylines: _polylines,
      ),
    );
  }
}
