import 'package:flutter/material.dart';

class NotificationListTile extends StatelessWidget {
  final String textTime;
  final String textNotification;
  final ImageIcon icon;

  const NotificationListTile(
      {super.key, required this.textTime, required this.textNotification, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      leading: icon,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textTime,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4),
          Text(
            textNotification,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.keyboard_arrow_down),
    );
  }
}
