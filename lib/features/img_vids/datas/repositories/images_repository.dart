import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/img_vids/datas/data_source/representation_remote_data_source.dart';
import 'dart:io';

import 'package:yourmanager/features/img_vids/domain/repositories/representation_repository.dart';

class ImagesRepository extends ReprensentionRepository {
  final RepresentationRemoteDataSource _dataSource;
  ImagesRepository(this._dataSource);
  @override
  ResultVoid deleteImage(String imagePath) async {
    try {
      final result = await _dataSource.deleteImage(imagePath);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> getImage(String imagePath) async {
    try {
      final result = await _dataSource.getImage(imagePath);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> uplaodImage(File imageFile) async {
    try {
      final result = await _dataSource.uplaodImage(imageFile);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
