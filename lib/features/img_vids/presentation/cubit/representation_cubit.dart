import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/delete_image.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/get_image.dart';
import 'package:yourmanager/features/img_vids/domain/usecases/upload_image.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';

class RepresentationCubit extends Cubit<RepresentationState> {
  final UploadImage _uploadImage;
  final GetImage _getImage;
  final DeleteImage _deleteImage;

  RepresentationCubit({
    required UploadImage uploadImage,
    required GetImage getImage,
    required DeleteImage deleteImage,
  })  : _uploadImage = uploadImage,
        _getImage = getImage,
        _deleteImage = deleteImage,
        super(const RepresentationInitial());

  Future<void> uploadImage(File imageFile) async {
    final result = await _uploadImage(imageFile);

    result.fold(
      (failure) => emit(const ImageUploadFailed(
          "we couldn't upload your image, please try again.")),
      (path) {
        emit(ImageUploadSuccessfully(path));
      },
    );
  }

  Future<void> getImage(String imagePath) async {
    emit(const IsGettingTheImage());
    final result = await _getImage(imagePath);
    result.fold(
        (failure) => emit(const GetImageFailed(
            "a problem occured while trying to get the image, try again.")),
        (imageUrl) => emit(GetImageSuccessfully(imageUrl)));
  }

  Future<void> deleteImage(String imagePath) async {
    final result = await _deleteImage(imagePath);
    result.fold(
        (failure) => emit(const DeleteImageFailed(
            "Sorry, we couldn't delete this image, please try again.")),
        (_) => emit(const DeleteImageSuccessfully()));
  }

  Future<void> taskDone(dynamic val) async {
    emit(IsTaskDone(val));
  }
}
