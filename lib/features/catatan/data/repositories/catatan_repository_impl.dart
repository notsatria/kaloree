import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/catatan/data/datasource/catatan_remote_datasource.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';
import 'package:kaloree/features/catatan/domain/repositories/catatan_repository.dart';

class CatatanRepositoryImpl implements CatatanRepository {
  final CatatanRemoteDataSource dataSource;

  CatatanRepositoryImpl(this.dataSource);
  @override
  Future<Either<Failure, CatatanListByMonth>> getCatatanListByMonth() async {
    try {
      final result = await dataSource.getCatatanListByMonth();
      return right(result);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
