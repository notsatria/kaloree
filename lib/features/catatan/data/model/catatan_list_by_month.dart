import 'package:kaloree/core/model/classification_result.dart';

class CatatanListByMonth {
  final Map<String, Map<String, List<ClassificationResult>>> catatanByMonthAndDay;

  CatatanListByMonth({required this.catatanByMonthAndDay});

  factory CatatanListByMonth.fromMap(
      Map<String, Map<String, List<ClassificationResult>>> map) {
    return CatatanListByMonth(catatanByMonthAndDay: map);
  }

  Map<String, dynamic> toMap() {
    return {
      'catatanByMonthAndDay': catatanByMonthAndDay.map((month, dayMap) => MapEntry(
            month,
            dayMap.map((day, list) => MapEntry(day, list.map((e) => e.toMap()).toList())),
          )),
    };
  }

  @override
  String toString() {
    return 'CatatanListByMonth{catatanByMonthAndDay: $catatanByMonthAndDay}';
  }
}
