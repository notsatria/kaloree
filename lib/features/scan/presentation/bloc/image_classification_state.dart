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

  const ImageClassificationSuccess(
      this.classification, this.imageClassificationHelper);
}

class ImageClassificationFailure extends ImageClassificationState {
  final String error;

  const ImageClassificationFailure(this.error);
}

class GetFoodDetailLoading extends ImageClassificationState {}

class GetFoodDetailSuccess extends ImageClassificationState {
  final Food food;

  const GetFoodDetailSuccess(this.food);
}

class GetFoodDetailFailure extends ImageClassificationState {
  final String error;

  const GetFoodDetailFailure(this.error);
}

class SaveClassificationResultLoading extends ImageClassificationState {}

class SaveClassificationResultSuccess extends ImageClassificationState {
  final String message;

  const SaveClassificationResultSuccess(
      [this.message = 'Makanan berhasil disimpan']);
}

class SaveClassificationResultFailure extends ImageClassificationState {
  final String error;

  const SaveClassificationResultFailure(this.error);
}

class UploadImageToStorageSuccess extends ImageClassificationState {
  final String imageUrl;

  const UploadImageToStorageSuccess(this.imageUrl);
}

class UploadImageToStorageFailure extends ImageClassificationState {
  final String error;

  const UploadImageToStorageFailure(this.error);
}
