import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zadatak/screens/details_screen.dart';

import '../base/models/cities.dart';
import '../base/provider/coordinates.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  static const CameraPosition _initialCameraPosition = CameraPosition(
      target: LatLng(44.81138374724598, 20.45931503176689), zoom: 7);

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Test zadatak',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
          ),
          body: Column(
            children: [
              Expanded(
                child: GoogleMap(
                  myLocationButtonEnabled: false,
                  zoomControlsEnabled: false,
                  initialCameraPosition: GoogleMapScreen._initialCameraPosition,
                  markers: List<Marker>.generate(
                      cities.length,
                      (index) => Marker(
                          markerId: MarkerId(cities[index].name),
                          position: LatLng(
                              cities[index].latitude, cities[index].longitude),
                          infoWindow: InfoWindow(title: cities[index].name),
                          onTap: () async {
                            await context.read<Coordinates>().getAirQuality(
                                cities[index].latitude,
                                cities[index].longitude);
                            if (!mounted) return;
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    airQuality:
                                        context.watch<Coordinates>().airQuality,
                                    cityName: cities[index].name)));
                          })).toSet(),
                  //Marker,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                ),
              ),
            ],
          ),
        ),
      );

  final List<Cities> cities = [
    // 'Subotica',
    Cities(name: 'Subotica', latitude: 46.1, longitude: 19.6667),
    // 'Novi Sad',
    Cities(name: 'Novi Sad', latitude: 45.2517, longitude: 19.8369),
    // 'Beograd',
    Cities(
        name: 'Beograd',
        latitude: 44.81138374724598,
        longitude: 20.45931503176689),
    // 'Kragujevac',
    Cities(name: 'Kragujevac', latitude: 44.0167, longitude: 20.9167),
    // 'Užice',
    Cities(name: 'Užice', latitude: 43.8586, longitude: 19.8488),
    // 'Bor',
    Cities(name: 'Bor', latitude: 44.0749, longitude: 22.0959),
    // 'Niš',
    Cities(name: 'Niš', latitude: 43.3247, longitude: 21.9033)
  ];
}
