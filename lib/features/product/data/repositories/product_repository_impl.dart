import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/product/data/data_source/product_remote_data_source.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductRemoteDataSrc _productDataSrc;
  ProductRepositoryImpl(this._productDataSrc);
  @override
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
  ) async {
    try {
      final result = await _productDataSrc.addNewProduct(
          title,
          description,
          category,
          expirationDate,
          barcode,
          image,
          price,
          stockPrice,
          discount);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Product>> getAllProducts() async {
    try {
      final result = await _productDataSrc.getAllProducts();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> getProduct(String id) async {
    try {
      final result = await _productDataSrc.getProduct(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid removeProduct(String id) async {
    try {
      final result = await _productDataSrc.removeProduct(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> updateProductInformations(
    String id,
    String title,
    String description,
    String category,
    String image,
    double price,
    double stockPrice,
    double discount,
  ) async {
    try {
      final result = await _productDataSrc.updateProductInformations(
        id,
        title,
        description,
        category,
        image,
        price,
        stockPrice,
        discount,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Product> getProductByBarecode(String barecode) {
    // TODO: implement getProductByBarecode
    throw UnimplementedError();
  }
}
