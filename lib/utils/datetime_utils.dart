
import 'package:intl/intl.dart';

class DateTimeUtils {
  String getFormattedDate(String time) {
    final DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(time));
    final DateFormat formatter = DateFormat('HH:mm:ss');
    return formatter.format(dateTime);
  }
}