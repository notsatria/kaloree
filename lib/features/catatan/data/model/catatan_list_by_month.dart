import 'package:kaloree/core/model/classification_result.dart';

class CatatanListByMonth {
  final Map<String, List<ClassificationResult>> catatanByMonth;

  CatatanListByMonth({required this.catatanByMonth});

  factory CatatanListByMonth.fromMap(
      Map<String, List<ClassificationResult>> map) {
    return CatatanListByMonth(catatanByMonth: map);
  }

  Map<String, dynamic> toMap() {
    return {
      'catatanByMonth': catatanByMonth.map(
          (key, value) => MapEntry(key, value.map((e) => e.toMap()).toList())),
    };
  }

  @override
  String toString() {
    return 'CatatanListByMonth{catatanByMonth: $catatanByMonth}';
  }
}
