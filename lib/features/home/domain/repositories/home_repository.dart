import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';

abstract interface class HomeRepository {
  Future<Either<Failure, UserModel>> getUserData();
  Future<Either<Failure, double>> getDailyCaloriesSupplied();
  Future<Either<Failure, void>> saveRecommendation(
      {required bool isSportRecommendation, required String result});
}
