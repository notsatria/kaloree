import 'package:intl/intl.dart';

String formatDateTo({required DateTime date, format = 'yyyy-MM-dd'}) {
  return DateFormat(format).format(date);
}

DateTime getStartOfWeek(DateTime date) {
  return date.subtract(Duration(days: date.weekday - 1));
}

DateTime getEndOfWeek(DateTime date) {
  return date.add(Duration(days: DateTime.sunday - date.weekday));
}

String getDayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'monday';
    case DateTime.tuesday:
      return 'tuesday';
    case DateTime.wednesday:
      return 'wednesday';
    case DateTime.thursday:
      return 'thursday';
    case DateTime.friday:
      return 'friday';
    case DateTime.saturday:
      return 'saturday';
    case DateTime.sunday:
      return 'sunday';
    default:
      return '';
  }
}
