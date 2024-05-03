import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/img_vids/domain/repositories/representation_repository.dart';

class GetImage extends UseCaseWithParam<String, String> {
  final ReprensentionRepository _repository;
  const GetImage(this._repository);

  @override
  ResultFuture<String> call(String params) {
    return _repository.getImage(params);
  }
}
