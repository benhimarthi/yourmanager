import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class GetProduct extends UseCaseWithParam<Product, String> {
  late ProductRepository _repository;
  GetProduct(this._repository);

  @override
  ResultFuture<Product> call(String params) {
    return _repository.getProduct(params);
  }
}
