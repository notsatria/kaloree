import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/scan/domain/repositories/image_classification_repository.dart';

class UploadImageToStorageUseCase
    implements UseCase<String, UploadImageToStorageParams> {
  final ImageClassificationRepository repository;

  UploadImageToStorageUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(
      UploadImageToStorageParams params) async {
    return await repository.uploadImageToStorage(image: params.image);
  }
}

class UploadImageToStorageParams {
  final File image;

  UploadImageToStorageParams(this.image);
}
