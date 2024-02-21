import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';
import 'package:yourmanager/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:yourmanager/features/authentication/domain/usecases/update_user_informations.dart';

class AuthenticationRepoMock extends Mock implements AuthenticationRepository {}

void main() {
  late AuthenticationRepository repository;
  late UpdateUserInformations updateUserInformations;

  setUp(() {
    repository = AuthenticationRepoMock();
    updateUserInformations = UpdateUserInformations(repository);
    registerFallbackValue(const Users.empty());
  });

  test("should called [AuthenticationRepository.updateUserInformations]",
      () async {
    when(
      () => repository.updateUserInformations(any()),
    ).thenAnswer((_) async => const Right(Users.empty()));

    final result = await updateUserInformations.call(const Users.empty());

    expect(result, equals(const Right<dynamic, Users>(Users.empty())));

    verify(
      () => repository.updateUserInformations(const Users.empty()),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
