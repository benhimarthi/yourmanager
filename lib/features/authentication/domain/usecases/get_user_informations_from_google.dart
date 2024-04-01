import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class GetUserInfosFromGoogle implements UseCaseWithoutParam<Users?> {
  final AuthenticationRepository _repository;
  GetUserInfosFromGoogle(this._repository);
  @override
  ResultFuture<Users?> call() {
    return _repository.getUserInformationsFromGoogle();
  }
}
