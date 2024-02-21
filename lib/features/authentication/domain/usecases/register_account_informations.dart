import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class RegisterAccountInformations extends UseCaseWithParam<Users, Users> {
  final AuthenticationRepository _repository;
  RegisterAccountInformations(this._repository);

  @override
  ResultFuture<Users> call(Users params) {
    return _repository.registerAccountInformations(params);
  }
}
