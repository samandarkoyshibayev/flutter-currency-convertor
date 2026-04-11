import 'package:intl/intl.dart';

abstract class AppDateUtils {
  // Parse
  static DateTime? tryParse(String? value) {
    if (value == null || value.isEmpty) return null;
    return DateTime.tryParse(value);
  }
  static DateTime parseOrNow(String? value) =>
      tryParse(value) ?? DateTime.now();

  // Format
  static String format(DateTime date, [String pattern = 'dd.MM.yyyy']) =>
      DateFormat(pattern).format(date);
  static String formatOrEmpty(  DateTime? date, [
    String pattern = 'dd.MM.yyyy',
  ]) => date == null ? '' : format(date, pattern);
  static String toIso(DateTime date) => date.toIso8601String();

  // Range
  static List<DateTime> daysInMonth(int year, int month) {
    final last = DateTime(year, month + 1, 0);
    return List.generate(last.day, (i) => DateTime(year, month, i + 1));
  }
  static int daysBetween(DateTime from, DateTime to) =>
      to.difference(from).inDays.abs();

  // Checks
  static bool isExpired(DateTime date) => date.isBefore(DateTime.now());
  static bool isSameDay(DateTime a, DateTime b) =>
      a.day == b.day && a.month == b.month && a.year == b.year;
}
