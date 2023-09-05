import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _mapController;
  LatLng? _currentPosition; // Make _currentPosition nullable

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLng(_currentPosition ?? const LatLng(0, 0)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentPosition ?? const LatLng(0, 0),
          zoom: 15.0,
        ),
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        markers: {
          Marker(
            markerId: const MarkerId('currentLocation'),
            position: _currentPosition ?? const LatLng(0, 0),
            infoWindow: const InfoWindow(title: 'Current Location'),
          ),
        },
      ),
    );
  }
}
