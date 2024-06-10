import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image/image.dart' as img;
import 'package:kaloree/core/helpers/image_classification_helper.dart';

part 'image_classification_event.dart';
part 'image_classification_state.dart';

class ImageClassificationBloc
    extends Bloc<ImageClassificationEvent, ImageClassificationState> {
  final ImageClassificationHelper _helper;

  ImageClassificationBloc(this._helper) : super(ImageClassificationInitial()) {
    on<ClassifyImage>(_onClassifyImage);
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
}
