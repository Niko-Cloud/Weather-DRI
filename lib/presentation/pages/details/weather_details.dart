import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:niko_driweather/presentation/blocs/home/weather_bloc.dart';
import 'package:niko_driweather/utils/color_palette.dart';
import 'package:niko_driweather/utils/helper.dart';

import 'daily_details.dart';
import 'hourly_details.dart';

class WeatherDetails extends StatefulWidget {
  final double latitude;
  final double longitude;

  const WeatherDetails(
      {Key? key, required this.latitude, required this.longitude})
      : super(key: key);

  @override
  _WeatherDetailsState createState() => _WeatherDetailsState();
}

class _WeatherDetailsState extends State<WeatherDetails> {
  @override
  void initState() {
    super.initState();
    context.read<WeatherBloc>().add(FetchWeatherForecast(
          latitude: widget.latitude,
          longitude: widget.longitude,
          timesteps: '1h',
          currentHours: DateTime.now(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Container(
              constraints: BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img/Home.png'),
                  fit: BoxFit
                      .cover,
                ),
              ),
              child: Center(
                child:
                    CircularProgressIndicator(),
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is WeatherLoaded) {
            final weatherHourlyEntities = state.weatherListHourly;
            final weatherDailyEntites = state.weatherListDaily;

            return Center(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/Home.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                                size: 24,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Back',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  shadows: [
                                    BoxShadow(
                                      color: ColorPalette.shadow,
                                      offset: Offset(-3, 3),
                                      blurRadius: 4,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: ColorPalette.shadow,
                                    offset: Offset(-3, 3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Text(
                              formattedDateShort,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: ColorPalette.shadow,
                                    offset: Offset(-3, 3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                              weatherHourlyEntities.length,
                              (index) => HourlyDetails(
                                  index: index,
                                  currentHour: formatTime(
                                      weatherHourlyEntities[index].time!),
                                  temperature:
                                      weatherHourlyEntities[index].temperature,
                                  weatherCode: weatherHourlyEntities[index]
                                      .weatherCode)),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Next Forecast',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: ColorPalette.shadow,
                                    offset: Offset(-3, 3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                            // Material(
                            //   color: Colors.transparent,
                            //   child: InkWell(
                            //     onTap: () {
                            //       showModalBottomSheet(
                            //         context: context,
                            //         builder: (context) {
                            //           return MonthPickerBottomSheet(
                            //             onMonthSelected:
                            //                 (DateTime selectedMonth) {
                            //               print(
                            //                   "Selected month: ${selectedMonth.month}");
                            //             },
                            //             initialDate: DateTime.now(),
                            //           );
                            //         },
                            //       );
                            //     },
                            //     child: Image(
                            //         image: const AssetImage(
                            //             'assets/img/calendar.png'),
                            //         width: 24),
                            //   ),
                            // ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: 60.0 * 7,
                          child: RawScrollbar(
                            thumbColor: Colors.white,
                            trackColor: Colors.white.withOpacity(0.2),
                            trackBorderColor: Colors.white.withOpacity(0.2),
                            trackRadius: Radius.circular(10),
                            thumbVisibility: true,
                            thickness: 8,
                            radius: Radius.circular(10),
                            trackVisibility: true,
                            interactive: true,
                            child: ListView.builder(
                              itemCount: weatherDailyEntites.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 6, 30, 6),
                                    child: DailyDetails(
                                      date: formatDate(
                                          weatherDailyEntites[index].time!),
                                      temperature: weatherDailyEntites[index]
                                          .temperature,
                                      weatherCode: weatherDailyEntites[index]
                                          .weatherCode,
                                    ));
                              },
                            ),
                          ),
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageIcon(
                              const AssetImage('assets/img/sun.png'),
                              color: Colors.white,
                              size: 28,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'DRI Weather',
                              style: const TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    color: ColorPalette.shadow,
                                    offset: Offset(-3, 3),
                                    blurRadius: 4,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
