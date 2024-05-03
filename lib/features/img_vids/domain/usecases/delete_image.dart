import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/img_vids/domain/repositories/representation_repository.dart';

class DeleteImage extends UseCaseWithParam<void, String> {
  final ReprensentionRepository _repository;
  const DeleteImage(this._repository);
  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteImage(params);
  }
}
