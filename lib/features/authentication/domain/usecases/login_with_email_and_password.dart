import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class LoginWithEmailAndPassword
    extends UseCaseWithParam<UserCredential, LoginWithEmailAndPasswordParams> {
  final AuthenticationRepository _repository;

  LoginWithEmailAndPassword(this._repository);

  @override
  ResultFuture<UserCredential> call(LoginWithEmailAndPasswordParams params) {
    return _repository.loginWithEmailAndPassword(
      params.email,
      params.password,
    );
  }
}

class LoginWithEmailAndPasswordParams {
  final String email;
  final String password;
  LoginWithEmailAndPasswordParams(this.email, this.password);
}
