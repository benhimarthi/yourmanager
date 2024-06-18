import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/expenditure/datas/data_source/expenditure_remote_data_source.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class ExpenditureRepositoryImpl extends ExpenditureRepository {
  final ExpenditureRemoteDataSource _dataSource;
  ExpenditureRepositoryImpl(this._dataSource);
  @override
  ResultVoid deleteExpenditure(String id) async {
    try {
      final result = await _dataSource.deleteExpenditure(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Expenditure>> getAllExpenditure() async {
    try {
      final result = await _dataSource.getAllExpenditure();
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Expenditure> getExpenditure(String id) async {
    try {
      final result = await _dataSource.getExpenditure(id);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> registerExpenditure(
      String title, double amount, DateTime date) async {
    try {
      final result = await _dataSource.registerExpenditure(title, amount, date);
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateExpenditure(
      String id, String title, double amount, DateTime date) async {
    try {
      final result = await _dataSource.updateExpenditure(
        id,
        title,
        amount,
        date,
      );
      return Right(result);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
