// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/domain/repositories/home_repository.dart';

class SaveRecommendationUseCase
    implements UseCase<void, SaveRecommendationParams> {
  final HomeRepository repository;

  SaveRecommendationUseCase(this.repository);
  @override
  Future<Either<Failure, void>> call(SaveRecommendationParams params) async {
    return await repository.saveRecommendation(
      isSportRecommendation: params.isSportRecommendation,
      result: params.result,
    );
  }
}

class SaveRecommendationParams {
  final bool isSportRecommendation;
  final String result;

  SaveRecommendationParams({
    required this.isSportRecommendation,
    required this.result,
  });
}
