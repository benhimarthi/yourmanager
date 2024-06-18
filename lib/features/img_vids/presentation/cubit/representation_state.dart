import 'package:equatable/equatable.dart';

class RepresentationState extends Equatable {
  const RepresentationState();
  @override
  List<Object?> get props => [];
}

class RepresentationInitial extends RepresentationState {
  const RepresentationInitial();
}

class ImageUploadSuccessfully extends RepresentationState {
  final String imageFile;
  const ImageUploadSuccessfully(this.imageFile);
}

class ImageUploadFailed extends RepresentationState {
  final String message;
  const ImageUploadFailed(this.message);
}

class IsGettingTheImage extends RepresentationState {
  const IsGettingTheImage();
}

class GetImageSuccessfully extends RepresentationState {
  final String imageLink;
  const GetImageSuccessfully(this.imageLink);
}

class GetImageFailed extends RepresentationState {
  final String message;
  const GetImageFailed(this.message);
}

class DeleteImageSuccessfully extends RepresentationState {
  const DeleteImageSuccessfully();
}

class DeleteImageFailed extends RepresentationState {
  final String message;
  const DeleteImageFailed(this.message);
}

class IsTaskDone extends RepresentationState {
  final dynamic value;
  const IsTaskDone(this.value);
}
