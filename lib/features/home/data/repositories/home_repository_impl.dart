import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/home/data/datasource/home_remote_datasource.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource datasource;

  HomeRepositoryImpl(this.datasource);
  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final res = await datasource.getUserData();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, double>> getDailyCaloriesSupplied() async {
    try {
      final res = await datasource.getDailyCaloriesSupplied();
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> saveRecommendation(
      {required bool isSportRecommendation, required String result}) async {
    try {
      final res = await datasource.saveRecommendation(
          isSportRecommendation: isSportRecommendation, result: result);
      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
