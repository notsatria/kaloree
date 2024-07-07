import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';
import 'package:kaloree/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:kaloree/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final result = await remoteDataSource.getUserData();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> editProfile(
      {required String fullName, File? image}) async {
    try {
      final result =
          await remoteDataSource.editProfile(fullName: fullName, image: image);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendation(
      {required bool isSportRecommendation}) async {
    try {
      final result = await remoteDataSource.getRecommendation(
          isSportRecommendation: isSportRecommendation);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
