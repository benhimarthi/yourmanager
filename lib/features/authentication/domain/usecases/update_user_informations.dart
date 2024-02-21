import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUserInformations extends UseCaseWithParam<void, Users> {
  final AuthenticationRepository _repository;
  UpdateUserInformations(this._repository);

  @override
  ResultVoid call(Users params) {
    return _repository.updateUserInformations(params);
  }
}
