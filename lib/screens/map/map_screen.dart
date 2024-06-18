import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  final LocationData currentLocation;

  const MapScreen({super.key, required this.currentLocation});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        centerTitle: true,
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.currentLocation.latitude!,
              widget.currentLocation.longitude!),
          zoom: 14.0,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: LatLng(widget.currentLocation.latitude!,
                widget.currentLocation.longitude!),
          ),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }
}
