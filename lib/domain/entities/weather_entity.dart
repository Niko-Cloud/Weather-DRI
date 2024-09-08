import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String weatherCode;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final DateTime? time;

  WeatherEntity({
    required this.weatherCode,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    this.time,
  });

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    DateTime? parsedTime;
    if (map['time'] != null) {
      try {
        parsedTime = DateTime.parse(map['time']).toUtc();
      } catch (e) {
        print('Error parsing time: $e');
      }
    }

    return WeatherEntity(
      weatherCode: map['values']?['weatherCode']?.toString() ?? '',
      temperature: map['values']?['temperature']?.toString() ?? '',
      humidity: map['values']?['humidity']?.toString() ?? '',
      windSpeed: map['values']?['windSpeed']?.toString() ?? '',
      time: parsedTime,
    );
  }

  @override
  List<Object?> get props => [weatherCode, temperature, humidity, windSpeed, time];
}
