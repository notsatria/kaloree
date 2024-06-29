import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/auth/domain/repositories/auth_repository.dart';

class UserRegisterGoogleUseCase implements UseCase<void, NoParams> {
  final AuthRepository authRepository;

  UserRegisterGoogleUseCase(this.authRepository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return authRepository.registerWithGoogle();
  }
}
