import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/core/usecase/usecase.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';
import 'package:kaloree/features/catatan/domain/repositories/catatan_repository.dart';

class GetCatatanListByMonthUseCase
    implements UseCase<CatatanListByMonth, NoParams> {
  final CatatanRepository repository;

  GetCatatanListByMonthUseCase(this.repository);
  @override
  Future<Either<Failure, CatatanListByMonth>> call(NoParams params) async {
    return await repository.getCatatanListByMonth();
  }
}
