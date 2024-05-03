import 'dart:io';

import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/img_vids/domain/repositories/representation_repository.dart';

class UploadImage extends UseCaseWithParam<String, File> {
  final ReprensentionRepository _repository;
  const UploadImage(this._repository);

  @override
  ResultFuture<String> call(File params) {
    return _repository.uplaodImage(params);
  }
}
