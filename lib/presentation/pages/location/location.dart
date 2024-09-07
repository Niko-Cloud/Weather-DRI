import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';
import 'package:niko_driweather/data/local/shared_pref.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeatherMapPage extends StatefulWidget {
  @override
  _WeatherMapPageState createState() => _WeatherMapPageState();
}

class _WeatherMapPageState extends State<WeatherMapPage> {
  late final MapController _mapController;
  LatLng _currentLocation = LatLng(0, 0);
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  final String _geocodingApiUrl = 'https://geocode.xyz';
  List<String> _recentSearches = [];

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _checkPermissionAndGetLocation();
  }

  Future<void> _checkPermissionAndGetLocation() async {
    final status = await Permission.location.status;

    if (status.isGranted) {
      getCurrentLocation();
    } else if (status.isDenied) {
      if (await Permission.location.request().isGranted) {
        getCurrentLocation();
      } else {
        _showPermissionDeniedDialog();
      }
    } else if (status.isPermanentlyDenied) {
      _showPermissionDeniedDialog();
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('latitude', position.latitude);
      await prefs.setDouble('longitude', position.longitude);

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      await prefs.setString('location', placemarks[0].locality!);

      _mapController.move(
        LatLng(position.latitude, position.longitude),
        13,
      );
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  Future<void> _searchLocation(String query) async {
    try {
      final response = await _dio.get(
        '$_geocodingApiUrl',
        queryParameters: {
          'locate': query,
          'json': '1',
        },
      );

      final data = response.data;

      print('API Response: $data');

      final latt = data['latt'];
      final longt = data['longt'];
      final locationName = data['city'];

      saveLocation(double.parse(latt.toString()), double.parse(longt.toString()), locationName.toString());


      if (latt != null && longt != null) {
        setState(() {
          _currentLocation = LatLng(
              double.parse(latt.toString()), double.parse(longt.toString()));
          _recentSearches.insert(0, query);
          if (_recentSearches.length > 5) _recentSearches.removeLast();
        });
        _mapController.move(_currentLocation, 13);
      }
    } catch (e) {
      print('Error fetching location: $e');
    }
  }

  void _showPermissionDeniedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission Required'),
          content: Text(
              'This app requires location permission to function properly. Please grant the location permission in the app settings.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                openAppSettings();
              },
              child: Text('Open Settings'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: _currentLocation,
                initialZoom: 9.2,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                  maxNativeZoom: 19,
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 80.0,
                      height: 80.0,
                      point: _currentLocation,
                      child: Icon(Icons.location_pin, color: Colors.red),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: InputDecoration(
                            hintText: 'Search Location',
                            border: InputBorder.none,
                            suffixIcon: IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                _searchLocation(_searchController.text);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _checkPermissionAndGetLocation,
        child: Icon(Icons.my_location),
      ),
    );
  }
}
