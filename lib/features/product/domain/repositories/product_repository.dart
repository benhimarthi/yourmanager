import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  ResultFuture<Product> addNewProduct(
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  );
  ResultFuture<Product> getProduct(String id);
  ResultFuture<List<Product>> getAllProducts();
  ResultFuture<Product> updateProductInformations(
    String id,
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  );
  ResultVoid removeProduct(String id);
}
