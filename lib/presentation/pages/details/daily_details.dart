import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';

class DailyDetails extends StatelessWidget {
  final String date;
  final String temperature;
  final String weatherCode;

  const DailyDetails(
      {Key? key,
        required this.date,
        required this.temperature,
        required this.weatherCode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              date,
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
              width: 80,
              height: 50,
            ),
            Spacer(),
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
          ],
        ),
      ),
    );
  }
}
