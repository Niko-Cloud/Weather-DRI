import 'package:flutter/material.dart';
import 'package:niko_driweather/utils/color_palette.dart';

class HourlyDetails extends StatelessWidget {
  final int index;

  const HourlyDetails({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final bool isMiddleItem = index == 2;

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
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                Text(
                  "24°C",
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
                  image: AssetImage('assets/img/sunny Cloudy.png'),
                  width: 70,
                  height: 50,
                ),
                Spacer(),
                Text(
                  "12:00",
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
