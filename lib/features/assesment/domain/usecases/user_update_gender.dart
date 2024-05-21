import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/assesment/domain/repositories/assesment_repository.dart';

class UserUpdateGender implements UseCase<void, UserUpdateGenderParams> {
  final AssesmentRepository repository;

  UserUpdateGender(this.repository);

  @override
  Future<Either<Failure, void>> call(UserUpdateGenderParams params) async {
    return await repository.updateGender(gender: params.gender);
  }
}

class UserUpdateGenderParams {
  final int gender;

  UserUpdateGenderParams({required this.gender});
}
