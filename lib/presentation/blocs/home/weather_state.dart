part of 'weather_bloc.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherEntity? weather;
  final List<WeatherEntity?> weatherList;
  final List<WeatherEntity> weatherListHourly;
  final List<WeatherEntity> weatherListDaily;

  const WeatherLoaded({this.weather, this.weatherList = const [], this.weatherListHourly = const [], this.weatherListDaily = const []});

  @override
  List<Object> get props => [weather ?? ''];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
