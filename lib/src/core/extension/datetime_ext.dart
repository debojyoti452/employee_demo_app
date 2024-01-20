import 'package:intl/intl.dart';

extension DateUtils on DateTime {
  bool get isToday {
    final now = DateTime.now().toUtc();
    return now.day == day && now.month == month && now.year == year;
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().toUtc().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  bool get isYesterday {
    final yesterday = DateTime.now().toUtc().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  bool isSameDay(DateTime other) {
    return other.day == day && other.month == month && other.year == year;
  }

  String formatCalendarMonthAndYear() {
    return DateFormat('MMMM yyyy').format(this);
  }

  String formatDate(String format) {
    return DateFormat(format).format(this);
  }
  String toFormattedString() {
    final monthNames = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];

    final month = monthNames[this.month - 1];
    final day = this.day.toString();

    return '$month $day';
  }
}
