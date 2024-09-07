import 'package:equatable/equatable.dart';

import '../../data/entity/weather_entity.dart';

class WeatherModel extends Equatable {
  final String weatherCode;
  final String temperature;
  final String humidity;
  final String windSpeed;
  final String time;

  const WeatherModel({
    required this.weatherCode,
    required this.temperature,
    required this.humidity,
    required this.windSpeed,
    required this.time,
  });

  factory WeatherModel.fromEntity(WeatherEntity entity) {
    return WeatherModel(
      weatherCode: entity.weatherCode,
      temperature: entity.temperature,
      humidity: entity.humidity,
      windSpeed: entity.windSpeed,
      time: entity.time,
    );
  }

  @override
  List<Object?> get props => [weatherCode, temperature, humidity, windSpeed, time];
}
