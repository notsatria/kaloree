import 'package:intl/intl.dart';

String formatDateTo({required DateTime date, format = 'yyyy-MM-dd'}) {
  return DateFormat(format).format(date);
}
