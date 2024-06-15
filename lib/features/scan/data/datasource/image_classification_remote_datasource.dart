import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kaloree/core/errors/exceptions.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/model/food.dart';

abstract interface class ImageClassificationRemoteDataSource {
  Future<Food> getFoodDetail({required String id});

  Future<void> saveClassificationResult(
      {required ClassificationResult classificationResult});

  Future<String> uploadImageToStorage({required String imagePath});
}

class ImageClassificationRemoteDataSourceImpl
    implements ImageClassificationRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final FirebaseStorage firebaseStorage;

  ImageClassificationRemoteDataSourceImpl(
    this.firebaseAuth,
    this.firebaseFirestore,
    this.firebaseStorage,
  );

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

  @override
  Future<void> saveClassificationResult(
      {required ClassificationResult classificationResult}) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        throw ServerException("User is not authenticated");
      }
      DocumentReference userDoc =
          firebaseFirestore.collection('users').doc(user.uid);

      final now = DateTime.now();
      final formatter = DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);

      DocumentReference resultDoc =
          userDoc.collection('classification_result').doc(formattedDate);

      await resultDoc.set({
        'classification_result_list':
            FieldValue.arrayUnion([classificationResult.toMap()]),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint(e.toString());
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImageToStorage({required String imagePath}) async {
    try {
      final userId = firebaseAuth.currentUser!.uid;
      final imageFile = File(imagePath);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = firebaseStorage
          .ref('user')
          .child(userId)
          .child('classification_result')
          .child(fileName);

      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;

      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
