import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUserAccount
    extends UseCaseWithParam<void, UpdateUserAccountParams> {
  final AuthenticationRepository _repository;

  UpdateUserAccount(this._repository);

  @override
  ResultFuture<void> call(UpdateUserAccountParams params) {
    return _repository.updateUserAccount(
      params.userId,
      params.displayName,
      params.image,
    );
  }
}

class UpdateUserAccountParams {
  final String userId;
  final String displayName;
  final String image;
  UpdateUserAccountParams(this.userId, this.displayName, this.image);
}
