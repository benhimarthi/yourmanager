import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class RemoveProduct extends UseCaseWithParam<void, String> {
  final ProductRepository _repository;
  RemoveProduct(this._repository);

  @override
  ResultFuture<void> call(String params) {
    return _repository.removeProduct(params);
  }
}
