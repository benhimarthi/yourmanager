import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/user_admin_manager_repository.dart';

class GetUser extends UseCaseWithParam<Users, String> {
  final UserAdminManagerRepository _adminManagerRepository;

  GetUser(this._adminManagerRepository);

  @override
  ResultFuture<Users> call(String params) {
    return _adminManagerRepository.getUser(params);
  }
}
