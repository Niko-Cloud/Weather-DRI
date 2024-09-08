import '../../domain/entities/weather_entity.dart';
import '../remote/api_service.dart';

class WeatherRepository {
  WeatherRepository();

  Future<List<WeatherEntity>> getWeatherForecastHourly(
      double latitude, double longitude, String timesteps, DateTime currentHours) async {
    try {
      final weatherData = await getWeatherDataForecast(latitude, longitude, timesteps);

      if (weatherData == null || weatherData['timelines'] == null || weatherData['timelines']['hourly'] == null) {
        throw Exception('No data returned from API');
      }

      List<dynamic> weatherList = weatherData['timelines']['hourly'] ?? [];

      DateTime currentDateTimeUtc = currentHours.toUtc();
      DateTime startDateTime = currentDateTimeUtc.subtract(Duration(hours: 2)).add(Duration(hours: 7));
      DateTime endDateTime = currentDateTimeUtc.add(Duration(hours: 2)).add(Duration(hours: 7));

      print('Start DateTime: $startDateTime');
      print('End DateTime: $endDateTime');

      List<WeatherEntity> weatherEntities = weatherList.map((item) {
        DateTime itemDateTime;
        try {
          itemDateTime = DateTime.parse(item['time']).toUtc();
        } catch (e) {
          itemDateTime = DateTime.now().toUtc();
        }

        DateTime localItemDateTime = itemDateTime.add(Duration(hours: 7));

        print('Original time: $itemDateTime, Local time: $localItemDateTime');

        return WeatherEntity(
          weatherCode: item['values']?['weatherCode']?.toString() ?? '',
          temperature: item['values']?['temperature']?.toString() ?? '',
          humidity: item['values']?['humidity']?.toString() ?? '',
          windSpeed: item['values']?['windSpeed']?.toString() ?? '',
          time: localItemDateTime,
        );
      }).where((entity) {
        if (entity.time == null) {
          return false;
        }
        print('Entity time: ${entity.time}');
        return entity.time!.isAfter(startDateTime) && entity.time!.isBefore(endDateTime);
      }).toList();

      weatherEntities.sort((a, b) => a.time!.compareTo(b.time!));

      if (weatherEntities.length > 5) {
        weatherEntities = weatherEntities.sublist(0, 5);
      }

      return weatherEntities;
    } catch (e) {
      print('Error fetching weather forecast: $e');
      rethrow;
    }
  }

  Future<List<WeatherEntity>> getWeatherForecastDaily(
      double latitude, double longitude, String timesteps) async {
    try {

      final weatherData = await getWeatherDataForecast(latitude, longitude, timesteps);

      if (weatherData == null ||
          weatherData['timelines'] == null ||
          weatherData['timelines']['daily'] == null) {
        throw Exception('No data returned from API or data is not in expected format');
      }

      List<dynamic> weatherList = weatherData['timelines']['daily'] ?? [];

      List<WeatherEntity> weatherEntities = weatherList.map((item) {

        DateTime itemDateTime;
        try {
          itemDateTime = DateTime.parse(item['time']).toUtc();
        } catch (e) {
          itemDateTime = DateTime.now().toUtc();
        }

        return WeatherEntity(
          weatherCode: item['values']?['weatherCodeMax']?.toString() ?? '',
          temperature: item['values']?['temperatureAvg']?.toString() ?? '',
          humidity: item['values']?['humidityAvg']?.toString() ?? '',
          windSpeed: item['values']?['windSpeedAvg']?.toString() ?? '',
          time: itemDateTime
        );
      }).toList();

      return weatherEntities;
    } catch (e) {
      print('Error fetching weather forecast: $e');
      rethrow;
    }
  }


  Future<WeatherEntity?> getWeatherRealtime(
      double latitude, double longitude) async {
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
