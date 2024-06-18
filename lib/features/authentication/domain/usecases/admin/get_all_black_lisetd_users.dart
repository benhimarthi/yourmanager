import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/user_admin_manager_repository.dart';

class GetAllBlackListedUser extends UseCaseWithoutParam<List<String>> {
  final UserAdminManagerRepository _repository;

  GetAllBlackListedUser(this._repository);

  @override
  ResultFuture<List<String>> call() {
    return _repository.getAllBlackLisetdUser();
  }
}
