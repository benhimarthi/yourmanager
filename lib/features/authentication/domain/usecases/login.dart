import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class Login extends UseCaseWithParam<Users, LoginParam> {
  final AuthenticationRepository _repository;
  Login(this._repository);

  @override
  ResultFuture<Users> call(LoginParam params) {
    return _repository.login(
      params.verificationId,
      params.smsCode,
      params.password,
    );
  }
}

class LoginParam {
  final String verificationId;
  final String smsCode;
  final String password;

  const LoginParam({
    required this.verificationId,
    required this.smsCode,
    required this.password,
  });
}
