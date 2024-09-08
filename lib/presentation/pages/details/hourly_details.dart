import 'package:flutter/material.dart';
import 'package:niko_driweather/utils/color_palette.dart';

class HourlyDetails extends StatelessWidget {
  final int index;
  final String currentHour;
  final String temperature;
  final String weatherCode;

  const HourlyDetails({
    super.key,
    required this.index,
    required this.currentHour,
    required this.temperature,
    required this.weatherCode,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMiddleItem = index == 1;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Container(
          width: double.infinity,
          height: 160,
          decoration: isMiddleItem
              ? BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.3),
                Colors.white.withOpacity(0.15),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          )
              : null,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  "$temperature°C",
                  style: TextStyle(fontSize: 20, color: Colors.white, shadows: [
                    BoxShadow(
                      color: ColorPalette.shadow,
                      offset: Offset(-3, 3),
                      blurRadius: 4,
                    ),
                  ]),
                ),
                Spacer(),
                Image(
                  image: AssetImage('assets/img/weather_code/${weatherCode}.png'),
                  width: 70,
                  height: 50,
                ),
                Spacer(),
                Text(
                  currentHour,
                  style: TextStyle(fontSize: 20, color: Colors.white, shadows: [
                    BoxShadow(
                      color: ColorPalette.shadow,
                      offset: Offset(-3, 3),
                      blurRadius: 4,
                    ),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
