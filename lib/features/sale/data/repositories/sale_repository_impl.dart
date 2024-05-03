import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/sale/data/data_source/sale_remote_data_source.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class SaleRepositoryImpl extends SaleRepository {
  final SaleRemoteDataSource _dataSource;
  SaleRepositoryImpl(this._dataSource);

  @override
  ResultVoid deleteSale(String id) async {
    try {
      final result = await _dataSource.deleteSale(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Sale>> getAllSales() async {
    try {
      final result = await _dataSource.getAllSales();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Sale> getSale(String saleId) async {
    try {
      final result = await _dataSource.getSale(saleId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid registerSale(String productId, int quantity, DateTime date) async {
    try {
      final result = await _dataSource.registerSale(productId, quantity, date);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
