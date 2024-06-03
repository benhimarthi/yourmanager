import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class GetProductByBarcode extends UseCaseWithParam<Product, String> {
  final ProductRepository _repository;
  GetProductByBarcode(this._repository);

  @override
  ResultFuture<Product> call(String params) {
    return _repository.getProductByBarecode(params);
  }
}
