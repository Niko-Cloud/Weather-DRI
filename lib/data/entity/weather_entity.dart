import 'package:equatable/equatable.dart';

class WeatherEntity extends Equatable {
  final String weatherCode;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final String time;

  WeatherEntity({
    required this.weatherCode,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.time,
  });

  factory WeatherEntity.fromMap(Map<String, dynamic> map) {
    return WeatherEntity(
      weatherCode: map['values']?['weatherCode']?.toString() ?? '',
      temperature: map['values']?['temperature']?.toString() ?? '',
      humidity: map['values']?['humidity']?.toString() ?? '',
      windSpeed: map['values']?['windSpeed']?.toString() ?? '',
      time: map['time'] ?? '',
    );
  }

  @override
  List<Object?> get props => [weatherCode, temperature, humidity, windSpeed, time];
}
