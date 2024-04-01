import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class AddNewProduct extends UseCaseWithParam<Product, CreateProductParams> {
  final ProductRepository _repository;
  AddNewProduct(this._repository);

  @override
  ResultFuture<Product> call(CreateProductParams params) {
    return _repository.addNewProduct(
      params.title,
      params.description,
      params.category,
      params.price,
      params.stockPrice,
      params.images,
    );
  }
}

class CreateProductParams {
  final String title;
  final String description;
  final String category;
  final double price;
  final double stockPrice;
  final List<String> images;
  CreateProductParams({
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.stockPrice,
    required this.images,
  });
}
