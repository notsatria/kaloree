import 'package:fpdart/fpdart.dart';
import 'package:kaloree/core/errors/failure.dart';
import 'package:kaloree/features/catatan/data/model/catatan_list_by_month.dart';

abstract interface class CatatanRepository {
  Future<Either<Failure, CatatanListByMonth>> getCatatanListByMonth();
}
