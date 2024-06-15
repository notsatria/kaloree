import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/food.dart';

abstract interface class ImageClassificationRemoteDataSource {
  Future<Food> getFoodDetail({required String id});
}

class ImageClassificationRemoteDataSourceImpl
    implements ImageClassificationRemoteDataSource {
  final FirebaseFirestore firebaseFirestore;

  ImageClassificationRemoteDataSourceImpl(this.firebaseFirestore);

  @override
  Future<Food> getFoodDetail({required String id}) async {
    try {
      DocumentReference foodDoc = firebaseFirestore.collection('food').doc(id);
      DocumentSnapshot foodSnapshot = await foodDoc.get();

      debugPrint("Food doc: $foodDoc");

      if (foodSnapshot.exists) {
        Map<String, dynamic> data = foodSnapshot.data() as Map<String, dynamic>;
        debugPrint("Food snapshot data: $data");
        return Food.fromMap(data);
      } else {
        throw ServerException("Food Snaphot doesnt exists");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e.toString());
    }
  }
}
