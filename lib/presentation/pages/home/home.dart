import 'package:flutter/material.dart';
import 'package:niko_driweather/presentation/pages/details/weather_details.dart';
import 'package:niko_driweather/presentation/pages/home/notification.dart';
import 'package:niko_driweather/presentation/pages/onboard/onboard.dart';
import 'package:niko_driweather/utils/color_palette.dart';
import 'package:niko_driweather/utils/constant.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/img/Home.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const ImageIcon(
                          AssetImage('assets/img/map.png'),
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () {
                            //TODO: Add nav to location
                          },
                          child: const Row(
                            children: [
                              Text(
                                'Surabaya', // TODO : Change to location
                                style: TextStyle(
                                  fontFamily: 'Overpass',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      color: ColorPalette.shadow,
                                      offset: Offset(-2, 3),
                                      blurRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return NotificationModal();
                                },
                              );
                            },
                            child: const Image(
                              image:
                                  AssetImage('assets/img/notification_on.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    // TODO : Change Icon Based Weather
                    const Image(
                      image: AssetImage('assets/img/sunny Cloudy.png'),
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                    const Spacer(),
                    AspectRatio(
                      aspectRatio: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Today $formattedDate',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    shadows: [
                                      Shadow(
                                        color: ColorPalette.shadow,
                                        offset: Offset(-2, 3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: '29',
                                        style: TextStyle(
                                          fontSize: 120,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              offset: const Offset(-9, 8),
                                              blurRadius: 130,
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextSpan(
                                        text: '°',
                                        style: TextStyle(
                                          fontSize: 110,
                                          color: Colors.white,
                                          shadows: [
                                            Shadow(
                                              color:
                                                  Colors.black.withOpacity(0.6),
                                              offset: const Offset(-9, 8),
                                              blurRadius: 130,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  'Sunny', // TODO : Change to Weather
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        color: ColorPalette.shadow,
                                        offset: Offset(-2, 3),
                                        blurRadius: 2,
                                      ),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        ImageIcon(
                                          AssetImage('assets/img/wind.png'),
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        SizedBox(height: 16),
                                        ImageIcon(
                                          AssetImage('assets/img/humid.png'),
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      children: [
                                        Text(
                                          "Wind",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: ColorPalette.shadow,
                                                offset: Offset(-2, 3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Hum",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: ColorPalette.shadow,
                                                offset: Offset(-2, 3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 24,
                                          child: VerticalDivider(
                                            color: Colors.white,
                                            thickness: 2,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        SizedBox(
                                          height: 24,
                                          child: VerticalDivider(
                                            color: Colors.white,
                                            thickness: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 10),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "5 km/h",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: ColorPalette.shadow,
                                                offset: Offset(-2, 3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "80%",
                                          style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.white,
                                            shadows: [
                                              Shadow(
                                                color: ColorPalette.shadow,
                                                offset: Offset(-2, 3),
                                                blurRadius: 2,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          const BoxShadow(
                            color: ColorPalette.shadow,
                            blurRadius: 33,
                            spreadRadius: -60,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WeatherDetails()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          overlayColor: Colors.black,
                          elevation: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Weather Details',
                              style: TextStyle(
                                color: ColorPalette.textDark,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 8), //
                            Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: ColorPalette.textDark,
                              size: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
