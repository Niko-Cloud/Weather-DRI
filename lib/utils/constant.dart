import 'package:intl/intl.dart';

DateTime now = DateTime.now().toUtc().add(const Duration(hours: 7));
String formattedDate = DateFormat('dd MMMM').format(now);
String formattedDateShort = DateFormat('d, MMM').format(now);