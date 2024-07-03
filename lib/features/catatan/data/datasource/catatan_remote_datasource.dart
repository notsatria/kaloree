import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';

abstract class CatatanRemoteDataSource {
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

      // CollectionReference classificationCollection = firestore
      //     .collection('users')
      //     .doc(uid)
      //     .collection('classification_result');

      // Ambil bulan dan tahun saat ini
      DateTime now = DateTime.now();
      DateTime startOfMonth = DateTime(now.year, now.month, 1);
      DateTime endOfMonth = DateTime(now.year, now.month + 1, 0);

      // Loop through each day of the current month
      for (int i = 0; i < endOfMonth.day; i++) {
        DateTime day = startOfMonth.add(Duration(days: i));
        String dayFormatted = DateFormat('yyyy-MM-dd').format(day);

        log('Day formatted: $dayFormatted');

        // Construct the path to the document
        String path = 'users/$uid/classification_result/$dayFormatted';

        try {
          // Get the document snapshot
          DocumentSnapshot snapshot = await firestore.doc(path).get();

          // Check if the document exists and has data
          if (snapshot.exists) {
            final data = snapshot.data() as Map<String, dynamic>;
            List<dynamic> classificationResultList =
                data['classification_result_list'] as List<dynamic>;

            var result = classificationResultList
                .map((classificationResult) =>
                    ClassificationResult.fromMap(classificationResult))
                .toList();

            String month = DateFormat('yyyy-MM').format(day);
            String dayKey = DateFormat('yyyy-MM-dd').format(day);

            if (!resultsByMonthAndDay.containsKey(month)) {
              resultsByMonthAndDay[month] = {};
            }
            if (!resultsByMonthAndDay[month]!.containsKey(dayKey)) {
              resultsByMonthAndDay[month]![dayKey] = [];
            }
            resultsByMonthAndDay[month]![dayKey]!.addAll(result);
          }
        } catch (e) {
          log('Error fetching data for $dayFormatted: $e');
          throw ServerException(e.toString());
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

      log('Result by month: $resultsByMonthAndDay');

      if (resultsByMonthAndDay.isEmpty) {
        throw ServerException('Catatan masih kosong!');
      }

      return CatatanListByMonth.fromMap(resultsByMonthAndDay);
    } catch (e) {
      debugPrint("Error fetching data: $e");
      throw ServerException(e.toString());
    }
  }
}
