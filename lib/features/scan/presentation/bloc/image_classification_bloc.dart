import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:kaloree/core/helpers/image_classification_helper.dart';
import 'package:kaloree/core/model/food.dart';
import 'package:kaloree/features/scan/domain/usecase/get_food_detail_usecase.dart';
import 'package:kaloree/features/scan/domain/usecase/save_classification_result_usecase.dart';

part 'image_classification_event.dart';
part 'image_classification_state.dart';

class ImageClassificationBloc
    extends Bloc<ImageClassificationEvent, ImageClassificationState> {
  final ImageClassificationHelper _helper;
  final GetFoodDetailUseCase _getFoodDetailUseCase;
  final SaveClassificationResultUseCase _saveClassificationResultUseCase;

  ImageClassificationBloc({
    required ImageClassificationHelper helper,
    required GetFoodDetailUseCase getFoodDetailUseCase,
    required SaveClassificationResultUseCase saveClassificationResultUseCase,
  })  : _helper = helper,
        _getFoodDetailUseCase = getFoodDetailUseCase,
        _saveClassificationResultUseCase = saveClassificationResultUseCase,
        super(ImageClassificationInitial()) {
    on<ClassifyImage>(_onClassifyImage);

    on<GetFoodDetailEvent>(_onGetFoodDetailEvent);

    on<SaveClassificationResult>(_onSaveClassificationResult);
  }

  Future<void> _onClassifyImage(
      ClassifyImage event, Emitter<ImageClassificationState> emit) async {
    emit(ImageClassificationLoading());
    try {
      final classification = await _helper.inferenceImage(event.image);
      debugPrint('Classification: $classification');
      emit(ImageClassificationSuccess(classification, _helper));
    } catch (e) {
      emit(ImageClassificationFailure(e.toString()));
    }
  }

  void _onGetFoodDetailEvent(
      GetFoodDetailEvent event, Emitter<ImageClassificationState> emit) async {
    emit(GetFoodDetailLoading());

    final result = await _getFoodDetailUseCase(GetFoodDetailParams(event.id));

    result.fold(
      (failure) => emit(GetFoodDetailFailure(failure.message)),
      (res) => emit(GetFoodDetailSuccess(res)),
    );
  }

  void _onSaveClassificationResult(SaveClassificationResult event,
      Emitter<ImageClassificationState> emit) async {
    emit(SaveClassificationResultLoading());

    final result = await _saveClassificationResultUseCase(
        SaveClassificationResultParams(event.food, event.image));

    result.fold(
      (failure) => emit(SaveClassificationResultFailure(failure.message)),
      (res) => emit(const SaveClassificationResultSuccess()),
    );
  }
}
