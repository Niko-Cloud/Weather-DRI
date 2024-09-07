import '../entity/weather_entity.dart';
import '../remote/api_service.dart'; // Import the file where your API service functions are defined.

class WeatherRepository {
  WeatherRepository();

  Future<List<WeatherEntity>> getWeatherForecastHourly(double latitude, double longitude, String timesteps) async {
    try {
      final weatherData = await getWeatherDataForecast(latitude, longitude, timesteps);

      if (weatherData == null || weatherData['data'] == null) {
        throw Exception('No data returned from API');
      }

      List<dynamic> weatherList = weatherData['data']['values'] ?? [];
      List<WeatherEntity> weatherEntities = weatherList
          .map((item) => WeatherEntity.fromMap(item))
          .toList();

      return weatherEntities;
    } catch (e) {
      print('Error fetching weather forecast: $e');
      rethrow;
    }
  }

  Future<WeatherEntity?> getWeatherRealtime(double latitude, double longitude) async {
    try {
      final weatherData = await getWeatherDataRealtime(latitude, longitude);

      if (weatherData == null || weatherData['data'] == null) {
        throw Exception('No data returned from API');
      }

      WeatherEntity weatherEntity = WeatherEntity.fromMap(weatherData['data']);

      return weatherEntity;
    } catch (e) {
      print('Error fetching real-time weather data: $e');
      rethrow;
    }
  }
}