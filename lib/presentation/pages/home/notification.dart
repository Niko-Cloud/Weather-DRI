import 'package:flutter/material.dart';
import 'package:niko_driweather/presentation/pages/home/notification_tile.dart';
import 'package:niko_driweather/utils/color_palette.dart';

class NotificationModal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Your Notification',
            style: TextStyle(
              fontSize: 28,
              color: ColorPalette.textDark,
              fontWeight: FontWeight.w700,
              shadows: [
                BoxShadow(
                  color: ColorPalette.shadow,
                  offset: Offset(-3, 3),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: [
                Text(
                  'New',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.textDark,
                  ),
                ),
                NotificationListTile(
                  textNotification: "A sunny day in your location, consider wearing your UV protection",
                  textTime: '10 minutes ago',
                  icon: ImageIcon(AssetImage(
                      'assets/img/sun.png'
                  )),
                ),
                Text(
                  'Earlier',
                  style: TextStyle(
                    fontSize: 12,
                    color: ColorPalette.textDark,
                  ),
                ),
                NotificationListTile(
                  textNotification: "A cloudy day will occur all day long, don't worry about the heat of the sun",
                  textTime: '1 day ago',
                  icon: ImageIcon(AssetImage(
                      'assets/img/wind.png'
                  )),
                ),
                NotificationListTile(
                  textNotification: "Potential for rain today is 84%, don't forget to bring your umbrella.",
                  textTime: '2 days ago',
                  icon: ImageIcon(AssetImage(
                      'assets/img/raini.png'
                  )),
                ),
              ],
            ),
          ),

          SizedBox(height: 16),
        ],
      ),
    );
  }
}
