import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, void>> editProfile(
      {required String fullName, File? image});
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      {required bool isSportRecommendation});
}
