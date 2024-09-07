import 'package:dio/dio.dart';

import '../../api/api_key.dart';

final dio = Dio();
const url = 'https://api.tomorrow.io/v4/weather';

Future<Map<String, dynamic>?> getWeatherDataForecast(double latitude, double longitude, String timesteps) async {
  try {
    final response = await dio.get('$url/forecast', queryParameters: {
      'location': '$latitude,$longitude',
      'timesteps': timesteps,
      'fields': 'temperature,weatherCode,humidity,windSpeed,time',
      'apikey': tomorrowApi,
    });

    if (response.statusCode == 200) {
      final weatherData = response.data;
      print('Weather Data: $weatherData');
      return weatherData;
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching weather data: $e');
    return null;
  }
}

Future<Map<String, dynamic>?> getWeatherDataRealtime(double latitude, double longitude) async {
  try {
    final response = await dio.get('$url/realtime', queryParameters: {
      'location': '$latitude,$longitude',
      'fields': 'temperature,weatherCode,humidity,windSpeed,time',
      'apikey': tomorrowApi,
    });

    if (response.statusCode == 200) {
      final weatherData = response.data;
      print('Weather Data: $weatherData');
      return weatherData; // Return the data
    } else {
      print('Failed to load weather data. Status code: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error fetching weather data: $e');
    return null;
  }
}
