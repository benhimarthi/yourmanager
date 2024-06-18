import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class UpdateUserInformations
    extends UseCaseWithParam<void, UpdateUserInformationsParams> {
  final AuthenticationRepository _repository;
  UpdateUserInformations(this._repository);

  @override
  ResultVoid call(UpdateUserInformationsParams params) {
    return _repository.updateUserInformations(
      params.id,
      params.fullName,
      params.image,
      params.phoneNumber,
    );
  }
}

class UpdateUserInformationsParams {
  final String id;
  final String fullName;
  final String image;
  final String phoneNumber;

  UpdateUserInformationsParams(
    this.id,
    this.fullName,
    this.image,
    this.phoneNumber,
  );
}
