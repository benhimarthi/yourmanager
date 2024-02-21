import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:yourmanager/features/authentication/domain/usecases/verify_phone_number.dart';

class AuthenticationRepoMock extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late VerifyPhoneNumber registerAccount;

  setUp(() {
    repository = AuthenticationRepoMock();
    registerAccount = VerifyPhoneNumber(repository);
  });

  test("should call [Repository.RegisterAccount]", () async {
    when(() => repository.verifyPhoneNumber(any(), any(), any()))
        .thenAnswer((_) async => const Right(null));

    final result = await registerAccount.call(VerificationParams(
      phoneNumber: 'phoneNumber',
      onCodeSent: (p0) {},
      onVerificationFailed: (p0) {},
    ));

    expect(result, const Right<dynamic, void>(null));
    verify(
      () => repository.verifyPhoneNumber(
        'phoneNumber',
        (p0) {},
        (p0) {},
      ),
    ).called(1);
    verifyNoMoreInteractions(repository);
  });
}
