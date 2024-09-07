import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niko_driweather/data/repository/weather_repository.dart';
import 'package:niko_driweather/presentation/pages/home/home.dart';
import 'package:niko_driweather/presentation/pages/onboard/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../blocs/home/weather_bloc.dart';

class App extends StatelessWidget {
  final WeatherRepository _weatherRepository;

  const App({
    super.key,
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => _weatherRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(weatherRepository: _weatherRepository),
          ),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  bool _isFirstTime = true;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? hasSeenOnboarding = prefs.getBool('hasSeenOnboarding');
    if (hasSeenOnboarding == null || !hasSeenOnboarding) {
      setState(() {
        _isFirstTime = true;
      });
    } else {
      setState(() {
        _isFirstTime = false;
      });
    }
  }

  Future<void> _completeOnboarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Overpass',
      ),
      home: _isFirstTime
          ? Onboard(onComplete: _completeOnboarding)
          : const Home(),
    );
  }
}
