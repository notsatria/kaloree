part of 'catatan_bloc.dart';

sealed class CatatanEvent extends Equatable {
  const CatatanEvent();

  @override
  List<Object> get props => [];
}

class GetCatatanListByMonth extends CatatanEvent {}