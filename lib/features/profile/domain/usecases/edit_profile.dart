import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/profile/domain/repositories/profile_repository.dart';

class EditProfileUseCase implements UseCase<void, EditProfileUseCaseParams> {
  final ProfileRepository repository;

  EditProfileUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(EditProfileUseCaseParams params) async {
    return await repository.editProfile(
      fullName: params.fullName,
      image: params.image,
    );
  }
}

class EditProfileUseCaseParams {
  final String fullName;
  final File? image;

  EditProfileUseCaseParams(this.fullName, this.image);
}
