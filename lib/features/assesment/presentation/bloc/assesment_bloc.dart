import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'assesment_event.dart';
part 'assesment_state.dart';

class AssesmentBloc extends Bloc<AssesmentEvent, AssesmentState> {
  AssesmentBloc() : super(AssesmentInitial()) {
    on<SavePersonalInfo>(
      (event, emit) => emit(
        PersonalInfoSaved(
          fullName: event.fullName,
          dateOfBirth: event.dateOfBirth,
          gender: event.gender,
          activityStatus: event.activityStatus,
          healthPurpose: event.healthPurpose,
          height: event.height,
          userId: event.userId,
          weight: event.weight,
        ),
      ),
    );
  }
}
