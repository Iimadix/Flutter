import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _mapController = MapController();

  final Map<String, LatLng> cities = {
    'Нижний Новгород': LatLng(56.326561, 44.008110),
    'Москва': LatLng(55.7558, 37.6173),
    'Санкт-Петербург': LatLng(59.9343, 30.3351),
    'Екатеринбург': LatLng(56.8389, 60.6057),
  };

  String selectedCity = 'Нижний Новгород';

  void _moveToCity(String city) {
    final target = cities[city];
    if (target != null) {
      _mapController.move(target, 12);
      setState(() {
        selectedCity = city;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Карта"),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: DropdownButton<String>(
              dropdownColor: const Color.fromARGB(255, 11, 186, 230),
              value: selectedCity,
              onChanged: (value) {
                if (value != null) _moveToCity(value);
              },
              items: cities.keys.map((String city) {
                return DropdownMenuItem<String>(
                  value: city,
                  child: Text(city, style: const TextStyle(color: Color.fromARGB(255, 39, 72, 255))),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: cities[selectedCity],
              zoom: 12,
              maxZoom: 18,
              minZoom: 3,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 80,
                    height: 80,
                    point: cities[selectedCity]!,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 12, 81, 231),
              onPressed: () => _moveToCity('Нижний Новгород'),
              child: const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
