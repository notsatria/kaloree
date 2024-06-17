// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:kaloree/core/model/classification_result.dart';

class CatatanListByMonth {
  final Map<String, List<ClassificationResult>> classificationResultList;

  CatatanListByMonth({required this.classificationResultList});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'classificationResultList': classificationResultList,
    };
  }

  factory CatatanListByMonth.fromMap(Map<String, dynamic> map) {
    return CatatanListByMonth(
        classificationResultList: Map<String, List<ClassificationResult>>.from(
      (map['classificationResultList']
          as Map<String, List<ClassificationResult>>),
    ));
  }

  String toJson() => json.encode(toMap());

  factory CatatanListByMonth.fromJson(String source) =>
      CatatanListByMonth.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CatatanListByMonth(classificationResultList: $classificationResultList)';
}
