import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/usecases/admin/get_user.dart';
import 'package:yourmanager/features/authentication/domain/usecases/get_user_informations_from_google.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login.dart';
import 'package:yourmanager/features/authentication/domain/usecases/login_with_email_and_password.dart';
import 'package:yourmanager/features/authentication/domain/usecases/register_account_informations.dart';
import 'package:yourmanager/features/authentication/domain/usecases/update_user_informations.dart';
import 'package:yourmanager/features/authentication/domain/usecases/verify_phone_number.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/authentication_state.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/users.dart';
import '../../domain/usecases/register_account_with_email_and_password.dart';
import '../../domain/usecases/update_user_account.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final Login _login;
  final RegisterAccountInformations _registerAccountInformations;
  final VerifyPhoneNumber _verifyPhoneNumber;
  final GetUserInfosFromGoogle _getUserInfosFromGoogle;
  final RegisterAccountWithEmailAndPassword _accountWithEmailAndPassword;
  final LoginWithEmailAndPassword _loginWithEmailAndPassword;
  final GetUser _getUser;
  final UpdateUserInformations _updateUserAccount;

  AuthenticationCubit({
    required Login login,
    required RegisterAccountInformations registerAccountInformations,
    required VerifyPhoneNumber verifyPhoneNumber,
    required GetUserInfosFromGoogle getUserInfosFromGoogle,
    required RegisterAccountWithEmailAndPassword
        registerAccountWithEmailAndPassword,
    required LoginWithEmailAndPassword loginWithEmailAndPassword,
    required GetUser getUser,
    required UpdateUserInformations updateUserAccount,
  })  : _login = login,
        _registerAccountInformations = registerAccountInformations,
        _verifyPhoneNumber = verifyPhoneNumber,
        _getUserInfosFromGoogle = getUserInfosFromGoogle,
        _accountWithEmailAndPassword = registerAccountWithEmailAndPassword,
        _loginWithEmailAndPassword = loginWithEmailAndPassword,
        _getUser = getUser,
        _updateUserAccount = updateUserAccount,
        super(const AuthenticationInitial());

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Failure) onVerificationFailed,
    Function(String) onVerificationCompleted,
    Users user,
  ) async {
    emit(const CreatingUser());
    emit(const WaitingConfirmationCode());
    final result = await _verifyPhoneNumber(
      VerificationParams(
        onCodeSent: (p0) {
          emit(ConfirmationCodeReceive(p0));
        },
        onVerificationFailed: (p0) {
          emit(OnConfirmationPhoneNumberFailed(p0.message));
        },
        onVerificationCompleted: (p0) {
          emit(const RegisterUserAccountInformations());
          registerAccountInformations(user);
        },
        phoneNumber: phoneNumber,
      ),
    );
    result.fold(
      (l) => emit(AccountRegisterFaild(l.message)),
      (r) => emit(
        const AccountRegisterEnd(),
      ),
    );
  }

  Future<void> registerAccountInformations(Users userToSave) async {
    final result = await _registerAccountInformations(userToSave);
    result.fold(
      (failure) => emit(RegisterUserAccountInformationsFailed(failure.message)),
      (user) => emit(RegisterUserAccountInformationsSuccessed(user)),
    );
  }

  Future<void> getUserInformationsFromGoogle() async {
    final result = await _getUserInfosFromGoogle();
    result.fold(
      (failure) => emit(AuthenticationWithGoogleFailed(failure.message)),
      (user) => emit(AuthenticationWithGoogleSuccessfull(user!)),
    );
  }

  Future<void> registerAccountWithEmailAndPassword(
      String email, String password) async {
    final result =
        await _accountWithEmailAndPassword(AccountParams(email, password));
    result.fold(
      (failure) =>
          emit(CreateUserAccountWithEmailAndPasswordFailed(failure.message)),
      (user) => emit(CreateUserAccountWithEmailAndPasswordSuccessfully(user)),
    );
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    final result =
        await _loginWithEmailAndPassword(LoginWithEmailAndPasswordParams(
      email,
      password,
    ));
    result.fold(
      (failure) {
        emit(LoginWithEmailAndPasswordFailed(failure.message));
      },
      (user) {
        emit(LoginWithEmailAndPasswordSuccessfully(user));
      },
    );
  }

  Future<void> getUser(String uid) async {
    emit(const GettingUser());
    final result = await _getUser(uid);
    result.fold(
      (failure) => emit(GetUserFailed(failure.message)),
      (user) => emit(GetUserSuccessfully(user as UserModel)),
    );
  }

  Future<void> updateUserAccount(
    String id,
    String fullName,
    String image,
    String phoneNumber,
  ) async {
    final result = await _updateUserAccount(UpdateUserInformationsParams(
      id,
      fullName,
      image,
      phoneNumber,
    ));
    result.fold(
      (failure) => emit(UpdateUserFailed(failure.message)),
      (_) => emit(const UpdateUserSuccessfully()),
    );
  }

  charged(String dt) {
    emit(Charged(dt));
  }
}
