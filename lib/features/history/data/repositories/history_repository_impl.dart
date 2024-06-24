import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/history/data/datasource/history_remote_datasource.dart';
import 'package:kaloree/features/history/domain/repositories/history_repository.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryRemoteDataSource remoteDataSource;

  HistoryRepositoryImpl(this.remoteDataSource);
  @override
  Future<Either<Failure, Map<String, double>>> getTotalCaloriesInWeek() async {
    try {
      final result = await remoteDataSource.getTotalCaloriesInWeek();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
