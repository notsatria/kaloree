part of 'image_classification_bloc.dart';

sealed class ImageClassificationState extends Equatable {
  const ImageClassificationState();

  @override
  List<Object> get props => [];
}

final class ImageClassificationInitial extends ImageClassificationState {}

class ImageClassificationLoading extends ImageClassificationState {}

class ImageClassificationSuccess extends ImageClassificationState {
  final Map<String, double> classification;
  final ImageClassificationHelper imageClassificationHelper;

  const ImageClassificationSuccess(this.classification, this.imageClassificationHelper);
}

class ImageClassificationFailure extends ImageClassificationState {
  final String error;

  const ImageClassificationFailure(this.error);
}