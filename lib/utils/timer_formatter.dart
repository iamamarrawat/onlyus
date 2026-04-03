import 'package:intl/intl.dart';

String formatSmartTimestamp(DateTime timestamp) {
  final now = DateTime.now();

  if (now.day == timestamp.day &&
      now.month == timestamp.month &&
      now.year == timestamp.year) {
    return DateFormat('h:mm a').format(timestamp); // Today
  }

  return DateFormat('EEE, h:mm a').format(timestamp);
}
