import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/data/stock_remote_data_source/stock_remote_data_src.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class StockRepositoryImpl extends StockRepository {
  final StockRemoteDataSource _dataSource;
  StockRepositoryImpl(this._dataSource);
  @override
  ResultFuture<String> addItemsInStock(
    int itemNumber,
    String productId,
    String stockId,
    String userId,
  ) async {
    try {
      final result = await _dataSource.addItemsInStock(
        itemNumber,
        productId,
        stockId,
        userId,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid removeItemFromStock(int quantity, String stockId) async {
    try {
      final result = await _dataSource.removeItemFromStock(quantity, stockId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Stock>> getAllStock() async {
    try {
      final result = await _dataSource.getAllStock();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Stock> getStock(String id) async {
    try {
      final result = await _dataSource.getStock(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      throw FirebaseFailure.fromException(e);
    }
  }

  @override
  ResultVoid removeStock(String id) async {
    try {
      final result = await _dataSource.removeStock(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Stock> getStockByUserId(String id) {
    throw UnimplementedError();
  }

  @override
  ResultVoid updateUserStock(
    String id,
    int quantity,
    int minQuantity,
    double stockCostPrice,
    double costPrice,
    double discount,
  ) async {
    try {
      final result = await _dataSource.updateUserStock(
        id,
        quantity,
        minQuantity,
        stockCostPrice,
        costPrice,
        discount,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid manageExpenditure(
      String id, String expenditureId, bool add) async {
    try {
      final result = await _dataSource.manageExpenditures(
        id,
        expenditureId,
        add,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid setConfiguredValue(String id, bool value) async {
    try {
      final result = await _dataSource.setConfiguredValue(id, value);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
