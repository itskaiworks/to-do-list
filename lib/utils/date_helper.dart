class DateHelper {
  static const List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];

  static DateTime dateOnly(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static String formatDate(DateTime dateTime) {
    final String monthName = _monthNames[dateTime.month - 1];
    return '$monthName ${dateTime.day}, ${dateTime.year}';
  }
  static String describeDate(DateTime dateTime, {DateTime? now}) {
    final DateTime today = dateOnly(now ?? DateTime.now());
    final DateTime target = dateOnly(dateTime);
    final int daysFromToday = DateTime.utc(target.year, target.month, target.day)
        .difference(DateTime.utc(today.year, today.month, today.day))
        .inDays;

    if (daysFromToday == 0) return 'Today';
    if (daysFromToday == 1) return 'Tomorrow';
    return formatDate(dateTime);
  }

  static bool isPastDate(DateTime dateTime, {DateTime? now}) {
    final DateTime today = dateOnly(now ?? DateTime.now());
    return dateOnly(dateTime).isBefore(today);
  }
}
