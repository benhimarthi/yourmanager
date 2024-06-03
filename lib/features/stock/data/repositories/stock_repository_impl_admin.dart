import 'package:dartz/dartz.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository_admin.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../stock_remote_data_source/stock_remote_data_src_admin.dart';

class StockRepositoryImplAdmin extends StockRepositoryAdmin {
  final StockRemoteDataSourceAdmin _dataSourceAdmin;

  StockRepositoryImplAdmin(this._dataSourceAdmin);
  @override
  ResultVoid createNewProductStock(String productId) async {
    try {
      final result = await _dataSourceAdmin.createNewProductStock(productId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<StockAdmin>> getAllProductStock() async {
    try {
      final result = await _dataSourceAdmin.getAllProductStock();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<StockAdmin> getProductStock(String id) async {
    try {
      final result = await _dataSourceAdmin.getProductStock(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<StockAdmin> getProductStockByProductId(String id) async {
    try {
      final result = await _dataSourceAdmin.getProductStockByProductId(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid removeProductStock(String id) async {
    try {
      final result = await _dataSourceAdmin.removeProductStock(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateProduct(
      String stockId, String userId, bool isNewUser, bool isAble) async {
    try {
      final result = await _dataSourceAdmin.updateProduct(
        stockId,
        userId,
        isNewUser,
        isAble: isAble,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
