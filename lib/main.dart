import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niko_driweather/presentation/pages/app.dart';
import 'package:niko_driweather/utils/bloc_observer.dart';
import 'package:niko_driweather/utils/helper.dart';

import 'data/repository/weather_repository.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await getCurrentLocation();

  Bloc.observer = const AppBlocObserver();

  runApp(App(
    weatherRepository: WeatherRepository(),
  ));
}