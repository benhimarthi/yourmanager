import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    String verificationId,
    String smsCode,
    String password,
  ) async {
    try {
      final u = await _dataSource.login(verificationId, smsCode, password);
      return Right(u);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateUserInformations(
    String id,
    String fullName,
    String image,
    String phoneNumber,
  ) async {
    try {
      await _dataSource.updateUserInformations(
        id,
        fullName,
        image,
        phoneNumber,
      );
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

  @override
  ResultFuture<Users?> getUserInformationsFromGoogle() async {
    try {
      final res = await _dataSource.getUserInformationsFromGoogle();
      return Right(res);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<UserCredential> registerAccountWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final res =
          await _dataSource.createAccountWithEmailAndPassword(email, password);
      return Right(res);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultVoid updateUserAccount(
    String userId,
    String displayName,
    String image,
  ) {
    // TODO: implement updateUserAccount
    throw UnimplementedError();
  }

  @override
  ResultFuture<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      final res = await _dataSource.loginWithEmailAndPassword(email, password);
      return Right(res);
    } on FirebaseExceptions catch (e) {
      return Left(FirebaseFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Users> getUser(String id) {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
