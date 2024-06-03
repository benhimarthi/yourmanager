import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/user_admin_manager_repository.dart';

class GetAllUsers extends UseCaseWithoutParam<List<Users>> {
  final UserAdminManagerRepository _adminManagerRepository;
  GetAllUsers(this._adminManagerRepository);

  @override
  ResultFuture<List<Users>> call() {
    return _adminManagerRepository.getAllUsers();
  }
}
