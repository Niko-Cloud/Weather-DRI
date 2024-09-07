import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/entity/weather_entity.dart';
import '../../../data/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({required this.weatherRepository}) : super(WeatherInitial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weather = await weatherRepository.getWeatherRealtime(
          event.latitude, event.longitude);
      print('Weather data loaded: $weather');
      emit(WeatherLoaded(weather: weather));
    } catch (e) {
      print('Weather fetch error: $e');
      emit(WeatherError(message: e.toString()));
    }
  }
}
