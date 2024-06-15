import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/classification_result.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/scan/domain/repositories/image_classification_repository.dart';

class SaveClassificationResultUseCase
    implements UseCase<void, SaveClassificationResultParams> {
  final ImageClassificationRepository repository;

  SaveClassificationResultUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(
      SaveClassificationResultParams params) async {
    return await repository.saveClassificationResult(
        classificationResult: params.classificationResult);
  }
}

class SaveClassificationResultParams {
  final ClassificationResult classificationResult;

  SaveClassificationResultParams(this.classificationResult);
}
