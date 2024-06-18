import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

class SignIntoGoogleAccount extends AuthenticationState {
  final GoogleSignInAccount? googleSignInAccount;
  const SignIntoGoogleAccount(this.googleSignInAccount);
}

class AuthenticationWithGoogleSuccessfull extends AuthenticationState {
  final Users users;
  const AuthenticationWithGoogleSuccessfull(this.users);
}

class AuthenticationWithGoogleFailed extends AuthenticationState {
  final String message;
  const AuthenticationWithGoogleFailed(this.message);
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

class WaitingConfirmationCode extends AuthenticationState {
  const WaitingConfirmationCode();
}

class ConfirmationCodeReceive extends AuthenticationState {
  final String code;
  const ConfirmationCodeReceive(this.code);
  @override
  List<Object?> get props => [code];
}

class ConfirmationCodeNotReceiveInTime extends AuthenticationState {
  const ConfirmationCodeNotReceiveInTime();
}

class OnConfirmationPhoneNumberFailed extends AuthenticationState {
  final String message;
  const OnConfirmationPhoneNumberFailed(this.message);
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError(this.message);
}

class CancelConfirmationProcess extends AuthenticationState {
  const CancelConfirmationProcess();
}

class RegisterUserAccountInformations extends AuthenticationState {
  const RegisterUserAccountInformations();
}

class RegisterUserAccountInformationsFailed extends AuthenticationState {
  final String message;
  const RegisterUserAccountInformationsFailed(this.message);
}

class RegisterUserAccountInformationsSuccessed extends AuthenticationState {
  final Users user;
  const RegisterUserAccountInformationsSuccessed(this.user);
}

class AccountRegisterEnd extends AuthenticationState {
  const AccountRegisterEnd();
}

class AccountRegisterFaild extends AuthenticationState {
  final String message;
  const AccountRegisterFaild(this.message);
}

class CreateUserAccountWithEmailAndPasswordSuccessfully
    extends AuthenticationState {
  final UserCredential myUser;
  const CreateUserAccountWithEmailAndPasswordSuccessfully(this.myUser);
}

class CreateUserAccountWithEmailAndPasswordFailed extends AuthenticationState {
  final String message;
  const CreateUserAccountWithEmailAndPasswordFailed(this.message);
}

class LoginWithEmailAndPasswordSuccessfully extends AuthenticationState {
  final UserCredential myUser;
  const LoginWithEmailAndPasswordSuccessfully(this.myUser);
}

class LoginWithEmailAndPasswordFailed extends AuthenticationState {
  final String message;
  const LoginWithEmailAndPasswordFailed(this.message);
}

class GettingUser extends AuthenticationState {
  const GettingUser();
}

class GetUserSuccessfully extends AuthenticationState {
  final UserModel myUser;
  const GetUserSuccessfully(this.myUser);
}

class GetUserFailed extends AuthenticationState {
  final String message;
  const GetUserFailed(this.message);
}

class UpdateUserSuccessfully extends AuthenticationState {
  const UpdateUserSuccessfully();
}

class UpdateUserFailed extends AuthenticationState {
  final String message;
  const UpdateUserFailed(this.message);
}

class Charged extends AuthenticationState {
  final String dt;
  const Charged(this.dt);
}
