import 'package:intl/intl.dart';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart';

DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
String formattedDate = DateFormat('dd MMMM').format(now);
String formattedDateShort = DateFormat('d, MMM').format(now);

String formatTime(DateTime dateTime) {
  return DateFormat('HH:mm').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd, MMM').format(dateTime);
}

Future<void> getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('latitude', position.latitude);
    await prefs.setDouble('longitude', position.longitude);

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    await prefs.setString('location', placemarks[0].locality!);
  } catch (e) {
    print('Error fetching location: $e');
  }
}
