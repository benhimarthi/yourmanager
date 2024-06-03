import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/user_admin_manager_repository.dart';

class DeleteUserAccount extends UseCaseWithParam<void, String> {
  final UserAdminManagerRepository _adminManagerRepository;

  DeleteUserAccount(this._adminManagerRepository);

  @override
  ResultFuture<void> call(String params) {
    return _adminManagerRepository.deleteUserAccount(params);
  }
}
