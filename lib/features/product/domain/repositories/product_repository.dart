import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';

abstract class ProductRepository {
  ResultFuture<Product> addNewProduct(
    String title,
    String description,
    String category,
    String expirationDate,
    String barcode,
    String image,
    double price,
    double stockPrice,
    double discount,
  );
  ResultFuture<Product> getProduct(String id);
  ResultFuture<Product> getProductByBarecode(String barecode);
  ResultFuture<List<Product>> getAllProducts();
  ResultFuture<Product> updateProductInformations(
    String id,
    String title,
    String description,
    String category,
    String image,
    double price,
    double stockPrice,
    double discount,
  );
  ResultVoid removeProduct(String id);
}
