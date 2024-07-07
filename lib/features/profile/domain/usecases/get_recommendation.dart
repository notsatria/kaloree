import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/home/data/model/recommendation.dart';
import 'package:kaloree/features/profile/domain/repositories/profile_repository.dart';

class GetRecommendationUseCase
    implements UseCase<List<Recommendation>, GetRecommendationParams> {
  final ProfileRepository repository;

  GetRecommendationUseCase(this.repository);
  @override
  Future<Either<Failure, List<Recommendation>>> call(
      GetRecommendationParams params) async {
    return await repository.getRecommendation(
        isSportRecommendation: params.isSportRecommendation);
  }
}

class GetRecommendationParams {
  final bool isSportRecommendation;

  GetRecommendationParams(this.isSportRecommendation);
}
