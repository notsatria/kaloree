import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/health_profile.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class UserGetHealthProfile implements UseCase<HealthProfile, NoParams> {
  final AssesmentRepository repository;

  UserGetHealthProfile(this.repository);

  @override
  Future<Either<Failure, HealthProfile>> call(NoParams params) async {
    return await repository.getUserHealthProfile();
  }
}
