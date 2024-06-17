part of 'catatan_bloc.dart';

sealed class CatatanState extends Equatable {
  const CatatanState();

  @override
  List<Object> get props => [];
}

final class CatatanInitial extends CatatanState {}

final class CatatanLoading extends CatatanState {}

final class CatatanFailure extends CatatanState {
  final String message;

  const CatatanFailure(this.message);
}

final class CatatanSuccess extends CatatanState {
  final CatatanListByMonth catatanListByMonth;

  const CatatanSuccess(this.catatanListByMonth);
}
