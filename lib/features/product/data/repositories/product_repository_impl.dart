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
    double price,
    double stockPrice,
    List<String> images,
  ) async {
    try {
      final result = await _productDataSrc.addNewProduct(
        title,
        description,
        category,
        price,
        stockPrice,
        images,
      );
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
      double price,
      double stockPrice,
      List<String> images) async {
    try {
      final result = await _productDataSrc.updateProductInformations(
        id,
        title,
        description,
        category,
        price,
        stockPrice,
        images,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
