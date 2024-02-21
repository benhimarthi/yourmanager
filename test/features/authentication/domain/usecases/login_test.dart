import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login.dart';

class AuthenticationRepoMock extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late Login login;

  setUp(() {
    repository = AuthenticationRepoMock();
    login = Login(repository);
  });

  LoginParam params = const LoginParam(
      verificationId: "verificationCode",
      smsCode: "smsCode",
      password: "password");
  test("should call [AuthenticationRepository.Login]", () async {
    when(() => repository.login(any(), any(), any()))
        .thenAnswer((_) async => const Right(Users.empty()));

    final result = await login.call(params);
    expect(result, const Right<dynamic, Users>(Users.empty()));

    verify(
      () => repository.login("verificationCode", "smsCode", "password"),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
