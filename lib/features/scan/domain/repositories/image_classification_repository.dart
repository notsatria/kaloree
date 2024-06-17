import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/food.dart';

abstract interface class ImageClassificationRepository {
  Future<Either<Failure, Food>> getFoodDetail({required String id});
  Future<Either<Failure, void>> saveClassificationResult({
    required Food food,
    required File image,
  });
}
