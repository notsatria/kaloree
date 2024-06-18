import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';

abstract interface class CatatanRemoteDataSource {
  Future<CatatanListByMonth> getCatatanListByMonth();
}

class CatatanRemoteDataSourceImpl implements CatatanRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  CatatanRemoteDataSourceImpl(this.firestore, this.auth);
  @override
  Future<CatatanListByMonth> getCatatanListByMonth() async {
    Map<String, Map<String, List<ClassificationResult>>> resultsByMonthAndDay =
        {};
    try {
      final uid = auth.currentUser!.uid;

      CollectionReference classificationCollection = firestore
          .collection('users')
          .doc(uid)
          .collection('classification_result');

      QuerySnapshot snapshot = await classificationCollection.get();

      for (var doc in snapshot.docs) {
        List<dynamic> classificationList = doc['classification_result_list'];
        for (var item in classificationList) {
          ClassificationResult result = ClassificationResult.fromMap(item);
          String month =
              DateFormat('yyyy-MM').format(DateTime.parse(result.createdAt));
          String day =
              DateFormat('yyyy-MM-dd').format(DateTime.parse(result.createdAt));

          if (!resultsByMonthAndDay.containsKey(month)) {
            resultsByMonthAndDay[month] = {};
          }
          if (!resultsByMonthAndDay[month]!.containsKey(day)) {
            resultsByMonthAndDay[month]![day] = [];
          }
          resultsByMonthAndDay[month]![day]!.add(result);
        }
      }
      // Mengurutkan hasil
      resultsByMonthAndDay.forEach((month, dayMap) {
        var sortedDays = dayMap.keys.toList()
          ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
        resultsByMonthAndDay[month] = {
          for (var day in sortedDays) day: dayMap[day]!
        };
      });
      return CatatanListByMonth.fromMap(resultsByMonthAndDay);
    } catch (e) {
      debugPrint("Error fetching data: $e");
      throw ServerException(e.toString());
    }
  }
}
