import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/weather_repository.dart';
import '../../../domain/entities/weather_entity.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
    on<FetchWeatherForecast>(_onFetchWeatherForecast);
  }

  Future<void> _onFetchWeatherForecast(FetchWeatherForecast event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherForecastHourly = await weatherRepository.getWeatherForecastHourly(
          event.latitude, event.longitude, event.timesteps, event.currentHours);
      final weatherForecastDaily = await weatherRepository.getWeatherForecastDaily(
          event.latitude, event.longitude, '1d');

      final weather = await weatherRepository.getWeatherRealtime(
          event.latitude, event.longitude);
      emit(WeatherLoaded(weather: weather, weatherListHourly: weatherForecastHourly, weatherListDaily: weatherForecastDaily));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getWeatherRealtime(
          event.latitude, event.longitude);
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }
}
