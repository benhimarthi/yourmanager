import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  ResultFuture<Product> addNewProduct(
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  ) {
    // TODO: implement addNewProduct
    throw UnimplementedError();
  }

  @override
  ResultFuture<List<Product>> getAllProducts() {
    // TODO: implement getAllProducts
    throw UnimplementedError();
  }

  @override
  ResultFuture<Product> getProduct(String id) {
    // TODO: implement getProduct
    throw UnimplementedError();
  }

  @override
  ResultVoid removeProduct(String id) {
    // TODO: implement removeProduct
    throw UnimplementedError();
  }

  @override
  ResultFuture<Product> updateProductInformations(
      String id,
      String title,
      String description,
      String category,
      double price,
      double stockPrice,
      List<String> images) {
    // TODO: implement updateProductInformations
    throw UnimplementedError();
  }
}
