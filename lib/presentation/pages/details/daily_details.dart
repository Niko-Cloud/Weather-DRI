import 'package:flutter/material.dart';

import '../../../utils/color_palette.dart';
import '../../../utils/constant.dart';

class DailyDetails extends StatelessWidget {
  const DailyDetails({Key? key}) : super(key: key);

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
              formattedDateShort,
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
              width: 80,
              height: 50,
            ),
            Spacer(),
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
          ],
        ),
      ),
    );
  }
}
