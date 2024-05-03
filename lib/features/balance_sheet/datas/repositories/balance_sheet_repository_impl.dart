import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/balance_sheet/datas/data_source/balance_sheet_remote_data_source.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class BalanceSheetRepositoryImpl extends BalanceSheetRepository {
  final BalanceSheetRemoteDataSource _dataSource;
  BalanceSheetRepositoryImpl(this._dataSource);
  @override
  ResultVoid createBalanceSheet(
      DateTime date, String saleId, String expenditureId) async {
    try {
      final result =
          await _dataSource.createBalanceSheet(date, saleId, expenditureId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteBalance(String id) async {
    try {
      final result = await _dataSource.deleteBalance(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<BalanceSheet>> getAllBalanceSheet() async {
    try {
      final result = await _dataSource.getAllBalanceSheet();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<BalanceSheet> getBalanceSheet(String id) async {
    try {
      final result = await _dataSource.getBalanceSheet(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateBalanceSheet(
    String id,
    String saleId,
    String expenditureId,
  ) async {
    try {
      final result =
          await _dataSource.updateBalanceSheet(id, saleId, expenditureId);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
