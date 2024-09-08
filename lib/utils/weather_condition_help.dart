import 'dart:convert';

import 'package:flutter/services.dart';

Future<Map<String, String>> loadWeatherCodesFromJson() async {
  final String jsonString = await rootBundle.loadString('assets/json/weatherCode.json');
  final Map<String, dynamic> jsonMap = json.decode(jsonString);
  return jsonMap.map((key, value) => MapEntry(key, value.toString()));
}