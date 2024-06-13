import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/model/food.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/scan/domain/repositories/image_classification_repository.dart';

class GetFoodDetailUseCase implements UseCase<Food, GetFoodDetailParams> {
  final ImageClassificationRepository repository;

  GetFoodDetailUseCase(this.repository);

  @override
  Future<Either<Failure, Food>> call(GetFoodDetailParams params) async {
    return await repository.getFoodDetail(id: params.id);
  }
}

class GetFoodDetailParams {
  final String id;

  GetFoodDetailParams(this.id);
}
