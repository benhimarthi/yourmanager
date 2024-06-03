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
      params.expirationDate,
      params.barcode,
      params.images,
      params.price,
      params.stockPrice,
      params.discount,
    );
  }
}

class CreateProductParams {
  final String title;
  final String description;
  final String category;
  final String expirationDate;
  final String barcode;
  final String images;
  final double price;
  final double stockPrice;
  final double discount;
  CreateProductParams({
    required this.title,
    required this.description,
    required this.category,
    required this.expirationDate,
    required this.barcode,
    required this.images,
    required this.price,
    required this.stockPrice,
    required this.discount,
  });
}
