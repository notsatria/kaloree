import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
import 'package:kaloree/features/history/data/datasource/analysis_remote_datasource.dart';
import 'package:kaloree/features/history/domain/repositories/analysis_repository.dart';

class AnalysisRepositoryImpl implements AnalysisRepository {
  final AnalysisRemoteDataSource remoteDataSource;

AnalysisRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Map<String, double>>> getTotalCaloriesInWeek() async {
    try {
      final result = await remoteDataSource.getTotalCaloriesInWeek();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserModel>> getUserData() async {
    try {
      final result = await remoteDataSource.getUserData();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
