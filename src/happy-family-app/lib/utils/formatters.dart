import 'package:fluttertest/utils/app_constants.dart';
import 'package:intl/intl.dart';

class Formatters {
  // Format Date to display only date
  static String formatDate(DateTime dateTime) {
    return DateFormat(AppConstants.dateFormat).format(dateTime);
  }

  // Format Date to display only time
  static String formatTime(DateTime time) {
    return DateFormat(AppConstants.timeFormat).format(time);
  }

  // Format Date to display date with week day
  static String formatDateWithWeekDay(DateTime dateTime) {
    return DateFormat(AppConstants.dateWeekDayFormat).format(dateTime);
  }

  // Format Date to display date with time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat(AppConstants.dateTimeFormat).format(dateTime);
  }
}
