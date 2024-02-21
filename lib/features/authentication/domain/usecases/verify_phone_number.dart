import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';

class VerifyPhoneNumber extends UseCaseWithParam<void, VerificationParams> {
  final AuthenticationRepository _repository;
  VerifyPhoneNumber(this._repository);

  @override
  ResultFuture<void> call(VerificationParams params) {
    return _repository.verifyPhoneNumber(
      params.phoneNumber,
      params.onCodeSent,
      params.onVerificationFailed,
      params.onVerificationCompleted,
    );
  }
}

class VerificationParams {
  final String phoneNumber;

  const VerificationParams({
    required this.phoneNumber,
    required this.onCodeSent,
    required this.onVerificationFailed,
    required this.onVerificationCompleted,
  });

  final Function(String) onCodeSent;
  final Function(Failure) onVerificationFailed;
  final Function(String) onVerificationCompleted;
}
