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

  CatatanRemoteDataSourceImpl({required this.firestore, required this.auth});
  @override
  Future<CatatanListByMonth> getCatatanListByMonth() async {
    Map<String, List<ClassificationResult>> resultsByMonth = {};
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

          if (!resultsByMonth.containsKey(month)) {
            resultsByMonth[month] = [];
          }
          resultsByMonth[month]!.add(result);
        }
      }
      final catatanListByMonth = CatatanListByMonth.fromMap(resultsByMonth);
      debugPrint(catatanListByMonth.toString());
      return catatanListByMonth;
    } catch (e) {
      debugPrint("Error fetching data: $e");
      throw ServerException(e.toString());
    }
  }
}
