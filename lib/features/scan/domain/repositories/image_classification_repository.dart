import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/food.dart';

abstract interface class ImageClassificationRepository {
  Future<Either<Failure, Food>> getFoodDetail({required String id});
}
