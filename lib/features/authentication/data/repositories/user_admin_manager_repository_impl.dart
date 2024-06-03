import 'package:dartz/dartz.dart';
import 'package:yourmanager/features/authentication/data/data_source/user_admin_manager_remote_data_source.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

import 'package:yourmanager/core/util/typedef.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/user_admin_manager_repository.dart';

class UserAdminManagerRepositoryImpl extends UserAdminManagerRepository {
  final UserAdminManagerRemoteDataSource _dataSource;

  UserAdminManagerRepositoryImpl(this._dataSource);

  @override
  ResultVoid blacklistUser(String id) async {
    try {
      final u = await _dataSource.blacklistUser(id);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid deleteUserAccount(String id) async {
    try {
      final u = await _dataSource.deleteUserAccount(id);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<Users>> getAllUsers() async {
    try {
      final u = await _dataSource.getAllUsers();
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Users> getUser(String id) async {
    try {
      final u = await _dataSource.getUser(id);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
