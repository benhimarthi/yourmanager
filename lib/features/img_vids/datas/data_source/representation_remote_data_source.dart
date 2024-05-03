import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:yourmanager/core/errors/exceptions.dart';

abstract class RepresentationRemoteDataSource {
  Future<String> uplaodImage(File imageFile);
  Future<String> getImage(String imagePath);
  Future<void> deleteImage(String imagePath);
}

class RepresentationRemoteDataSourceImpl
    extends RepresentationRemoteDataSource {
  final FirebaseStorage _firebaseStorage;
  RepresentationRemoteDataSourceImpl(this._firebaseStorage);

  @override
  Future<void> deleteImage(String imagePath) async {
    try {
      final ref = _firebaseStorage.ref().child(imagePath);
      ref.delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<String> getImage(String imagePath) async {
    try {
      final ref = _firebaseStorage.ref().child(imagePath);
      final imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<String> uplaodImage(File imageFile) async {
    try {
      String path = 'images/${DateTime.now().millisecondsSinceEpoch}';
      Reference storageReference = _firebaseStorage.ref(path);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      await uploadTask.whenComplete(() {
        return path;
      }).onError((error, stackTrace) =>
          throw FirebaseExceptions(message: error.toString(), statusCode: 404));
      return path;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
