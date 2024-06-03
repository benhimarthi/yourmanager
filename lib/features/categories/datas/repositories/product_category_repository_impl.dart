import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/categories/datas/data_source/product_category_remote_data_source.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

import '../models/product_category.dart';

class ProductCategoryRepositoryImpl extends ProductCategoryRepository {
  final ProductCategoryRemoteDataSource _dataSourceImpl;
  ProductCategoryRepositoryImpl(this._dataSourceImpl);

  @override
  ResultVoid addProductCategory(String categoryName, DateTime date) async {
    try {
      final result =
          await _dataSourceImpl.addProductCategory(categoryName, date);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteProductCategory(String id) async {
    try {
      final result = await _dataSourceImpl.deleteProductCategory(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<ProductCategory>> getAllProductCategories() async {
    try {
      final result = await _dataSourceImpl.getAllProductCategories();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<ProductCategory> getProductCategory(String id) async {
    try {
      final result = await _dataSourceImpl.getProductCategory(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateProductCategory(
    String id,
    String categoryName,
    DateTime date,
  ) async {
    try {
      final result =
          await _dataSourceImpl.updateProductCategory(id, categoryName, date);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
