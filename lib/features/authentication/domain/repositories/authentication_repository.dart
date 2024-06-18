import 'package:firebase_auth/firebase_auth.dart';
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
  ResultVoid updateUserInformations(
    String id,
    String fullName,
    String image,
    String phoneNumber,
  );
  ResultFuture<Users> registerAccountInformations(Users userToSave);
  ResultFuture<Users?> getUserInformationsFromGoogle();
  ResultFuture<UserCredential> registerAccountWithEmailAndPassword(
    String email,
    String password,
  );
  ResultFuture<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  );
  ResultVoid updateUserAccount(
    String userId,
    String displayName,
    String image,
  );
  ResultFuture<Users> getUser(String id);
}
