part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeather({required this.latitude, required this.longitude});

  @override
  List<Object> get props => [latitude, longitude];
}

class FetchWeatherForecast extends WeatherEvent {
  final double latitude;
  final double longitude;
  final String timesteps;
  final DateTime currentHours;

  const FetchWeatherForecast({
    required this.latitude,
    required this.longitude,
    required this.timesteps,
    required this.currentHours,
  });

  @override
  List<Object> get props => [latitude, longitude, timesteps, currentHours];
}
