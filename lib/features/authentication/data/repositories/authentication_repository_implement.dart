import 'package:dartz/dartz.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/authentication/data/data_source/authentication_remote_data_source.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSrc _dataSource;

  AuthenticationRepositoryImpl(this._dataSource);

  @override
  ResultFuture<Users> login(
      String verificationId, String smsCode, String password) async {
    try {
      final u = await _dataSource.login(verificationId, smsCode, password);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateUserInformations(Users user) async {
    try {
      await _dataSource.updateUserInformations(user as UserModel);
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid verifyPhoneNumber(
    String phoneNumber,
    Function(String p1) onCodeSent,
    Function(Failure p1) onVerificationFailed,
    Function(String) onVerificationCompleted,
  ) async {
    try {
      await _dataSource.verifyPhoneNumber(
        phoneNumber,
        (p0) => onCodeSent,
        (p0) => onVerificationFailed,
        (p0) => onVerificationCompleted,
      );
      return const Right(null);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Users> registerAccountInformations(Users userToSave) async {
    try {
      final u = await _dataSource
          .registerAccountInformations(userToSave as UserModel);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }
}
