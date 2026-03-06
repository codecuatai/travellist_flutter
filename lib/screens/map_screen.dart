import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/place.dart';

class MapScreen extends StatelessWidget {
  final Place place;
  const MapScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final latLng = LatLng(place.latitude, place.longitude);

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),
      body: FlutterMap(
        options: MapOptions(center: latLng, zoom: 13),
        children: [
          TileLayer(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.travelist02',
          ),
          MarkerLayer(
            markers: [
              Marker(
                width: 80,
                height: 80,
                point: latLng,
                builder: (ctx) =>
                    const Icon(Icons.location_on, color: Colors.red, size: 40),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
