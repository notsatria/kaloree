import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/user_model.dart';
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
}
