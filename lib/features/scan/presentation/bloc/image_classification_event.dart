part of 'image_classification_bloc.dart';

sealed class ImageClassificationEvent extends Equatable {
  const ImageClassificationEvent();

  @override
  List<Object> get props => [];
}

class ClassifyImage extends ImageClassificationEvent {
  final img.Image image;

  const ClassifyImage(this.image);
}

class GetFoodDetailEvent extends ImageClassificationEvent {
  final String id;

  const GetFoodDetailEvent(this.id);
}
