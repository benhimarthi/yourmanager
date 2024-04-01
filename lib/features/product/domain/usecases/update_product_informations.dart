import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class UpdateProductInformations
    extends UseCaseWithParam<Product, UpdateProductInfosParams> {
  final ProductRepository _repository;
  UpdateProductInformations(this._repository);

  @override
  ResultFuture<Product> call(UpdateProductInfosParams params) {
    return _repository.updateProductInformations(
      params.id,
      params.title,
      params.description,
      params.category,
      params.price,
      params.stockPrice,
      params.images,
    );
  }
}

class UpdateProductInfosParams {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double stockPrice;
  final List<String> images;
  UpdateProductInfosParams({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.stockPrice,
    required this.images,
  });
}
