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
      final ref = _firebaseStorage.ref().child('images/$imagePath');
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
      String filename = DateTime.now().millisecondsSinceEpoch.toString();
      String path = 'images/$filename';
      Reference storageReference = _firebaseStorage.ref().child(path);
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      taskSnapshot.ref.getDownloadURL().then((value) {});
      return filename;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
