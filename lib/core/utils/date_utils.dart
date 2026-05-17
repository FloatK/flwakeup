import 'package:intl/intl.dart';

class DateUtils {
  DateUtils._();

  static String formatDateRange(DateTime start, DateTime end) {
    final formatter = DateFormat('MM.dd');
    return '${formatter.format(start)} - ${formatter.format(end)}';
  }

  static DateTime weekStart(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1));
  }

  static DateTime weekEnd(DateTime date) {
    return weekStart(date).add(const Duration(days: 6));
  }

  static int currentWeekIndex(DateTime semesterStart, int totalWeeks) {
    final now = DateTime.now();
    final diff = now.difference(semesterStart).inDays;
    if (diff < 0) return 1;
    final week = (diff / 7).ceil() + 1;
    return week.clamp(1, totalWeeks);
  }
}
