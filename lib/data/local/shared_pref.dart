import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLocation(double latitude, double longitude, String location) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setDouble('latitude', latitude);
  await prefs.setDouble('longitude', longitude);
  await prefs.setString('location', location);
}

Future<Map<String, dynamic>> getLocation() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final double? latitude = prefs.getDouble('latitude');
  final double? longitude = prefs.getDouble('longitude');
  final String? location = prefs.getString('location');

  return {
    'latitude': latitude,
    'longitude': longitude,
    'location': location,
  };
}
