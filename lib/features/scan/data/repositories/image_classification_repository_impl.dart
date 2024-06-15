import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/model/food.dart';
import 'package:kaloree/features/scan/data/datasource/image_classification_remote_datasource.dart';
import 'package:kaloree/features/scan/domain/repositories/image_classification_repository.dart';

class ImageClassificationRepositoryImpl
    implements ImageClassificationRepository {
  final ImageClassificationRemoteDataSource remoteDataSource;

  ImageClassificationRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, Food>> getFoodDetail({required String id}) async {
    try {
      final result = await remoteDataSource.getFoodDetail(id: id);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveClassificationResult(
      {required ClassificationResult classificationResult}) async {
    try {
      final result = await remoteDataSource.saveClassificationResult(
          classificationResult: classificationResult);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadImageToStorage(
      {required File image}) async {
    try {
      final result = await remoteDataSource.uploadImageToStorage(image: image);
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
