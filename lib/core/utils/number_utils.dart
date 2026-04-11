import 'package:intl/intl.dart';

abstract class NumberUtils {
  static String formatCurrency(
    double amount, {
    String symbol = '\$',
    int decimals = 2,
    String locale = 'en_US',
  }) {
    final formatter = NumberFormat.currency(
      locale: locale,
      symbol: symbol,
      decimalDigits: decimals,
    );
    return formatter.format(amount);
  }
  static String formatUZS(double amount) => '${formatCompact(amount)} so\'m';

  static String formatCompact(num value) {
    if (value >= 1000000000) {
      return '${(value / 1000000000).toStringAsFixed(1)}B';
    }
    if (value >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (value >= 1000) return '${(value / 1000).toStringAsFixed(1)}K';
    return value.toString();
  }

  static String formatPercent(double value, {int decimals = 1}) =>
      '${value.toStringAsFixed(decimals)}%';
  static double percentage(double part, double total) =>
      total == 0 ? 0 : (part / total) * 100;

  static double clamp(double value, double min, double max) =>
      value.clamp(min, max);

  static String ordinal(int n) {
    if (n >= 11 && n <= 13) return '${n}th';
    return switch (n % 10) {
      1 => '${n}st',
      2 => '${n}nd',
      3 => '${n}rd',
      _ => '${n}th',
    };
  }
}
