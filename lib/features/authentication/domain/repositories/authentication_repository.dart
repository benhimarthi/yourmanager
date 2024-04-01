import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

abstract class AuthenticationRepository {
  ResultVoid verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Failure) onVerificationFailed,
    Function(String) onVerificationCompleted,
  );
  ResultFuture<Users> login(
      String verificationId, String smsCode, String password);
  ResultVoid updateUserInformations(Users user);
  ResultFuture<Users> registerAccountInformations(Users userToSave);
  ResultFuture<Users?> getUserInformationsFromGoogle();
}
