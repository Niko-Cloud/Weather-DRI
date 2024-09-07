import 'package:flutter/material.dart';
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
                    fontSize: 18,
                    color: ColorPalette.textDark,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification 1'),
                ),
                Text(
                  'Earlier',
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorPalette.textDark,
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.notifications),
                  title: Text('Notification 2'),
                ),
                // Add more notifications here
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
