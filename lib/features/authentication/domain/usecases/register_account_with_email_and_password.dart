import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class RegisterAccountWithEmailAndPassword
    extends UseCaseWithParam<UserCredential, AccountParams> {
  final AuthenticationRepository _repository;

  RegisterAccountWithEmailAndPassword(this._repository);

  @override
  ResultFuture<UserCredential> call(AccountParams params) {
    return _repository.registerAccountWithEmailAndPassword(
      params.userName,
      params.password,
    );
  }
}

class AccountParams {
  final String userName;
  final String password;

  AccountParams(this.userName, this.password);
}
