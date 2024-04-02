import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class GetAllProducts extends UseCaseWithoutParam<List<Product>> {
  final ProductRepository _repository;
  GetAllProducts(this._repository);
  @override
  ResultFuture<List<Product>> call() {
    return _repository.getAllProducts();
  }
}
