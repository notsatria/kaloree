import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/utils/date_format.dart';

abstract interface class AnalysisRemoteDataSource {
  Future<Map<String, double>> getTotalCaloriesInWeek();
}

class AnalysisRemoteDataSourceImpl implements AnalysisRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  AnalysisRemoteDataSourceImpl(this.firebaseFirestore, this.firebaseAuth);

  @override
  Future<Map<String, double>> getTotalCaloriesInWeek() async {
    DateTime now = DateTime.now();
    DateTime startOfWeek = _getStartOfWeek(now);

    final uid = firebaseAuth.currentUser!.uid;

    Map<String, double> weeklyCalories = {
      'monday': 0,
      'tuesday': 0,
      'wednesday': 0,
      'thursday': 0,
      'friday': 0,
      'saturday': 0,
      'sunday': 0
    };

    // Loop through each day from Monday to Sunday
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      String dayFormatted = formatDateTo(date: day);
      String dayName = _getDayName(day.weekday);

      log('Day formatted: $dayFormatted');

      // Construct the path to the document
      String path = 'users/$uid/classification_result/$dayFormatted';

      try {
        // Get the document snapshot
        DocumentSnapshot snapshot = await firebaseFirestore.doc(path).get();

        // Check if the document exists and has data
        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          List<dynamic> classificationResultList =
              data['classification_result_list'] as List<dynamic>;

          var result = classificationResultList
              .map((classificationResult) =>
                  ClassificationResult.fromMap(classificationResult))
              .toList();

          // Calculate the total calories for the day
          double totalCalories = result.fold(
              0,
              (sum, classificationResult) =>
                  sum + classificationResult.food.calories);

          // Add the total calories to the respective day in the map
          weeklyCalories[dayName] = totalCalories;
        }
      } catch (e) {
        log('Error fetching data for $dayFormatted: $e');
        throw ServerException(e.toString());
      }
    }

    log('Weekly calories $weeklyCalories');

    return weeklyCalories;
  }

  DateTime _getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _getDayName(int weekday) {
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
}
