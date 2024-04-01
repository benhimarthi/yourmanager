import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/core/util/password_hash.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthenticationRemoteDataSrc {
  Future<UserModel> login(
      String verificationId, String smsCode, String password);

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Failure) onVerificationFailed,
    Function(String) onVerificationCompleted,
  );

  Future<void> updateUserInformations(UserModel user);
  Future<UserModel> registerAccountInformations(UserModel userInformations);
  Future<UserModel?> getUserInformationsFromGoogle();
}

class AuthenticationRemoteDataSrcImpl extends AuthenticationRemoteDataSrc {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;
  final GoogleSignIn googleSignIn;
  AuthenticationRemoteDataSrcImpl(
      this._firebaseAuth, this._firebaseFirestore, this.googleSignIn);

  @override
  Future<UserModel> login(
      String verificationId, String smsCode, String password) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);
      final userCredential =
          await _firebaseAuth.signInWithCredential(credential);
      return UserModel.fromFirebaseUserCredential(userCredential.user);
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Failure) onVerificationFailed,
    Function(String) onVerificationCompleted,
  ) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        final userCed = await _firebaseAuth.signInWithCredential(credential);
        onVerificationCompleted(userCed.user!.uid);
      },
      verificationFailed: (FirebaseAuthException e) {
        onVerificationFailed(FirebaseFailure(
            statusCode: int.parse(e.code), message: "${e.message}"));
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Future<void> updateUserInformations(UserModel user) async {
    try {
      //Access the firestore collection for users
      CollectionReference userscollection =
          _firebaseFirestore.collection("users");

      //check if user already exist in Firestore
      DocumentSnapshot userSnapshot = await userscollection.doc(user.id).get();

      if (userSnapshot.exists) {
        await userscollection.doc(user.id).update({
          'full_name': user.fullName,
          'passeword': hashPassword(user.password),
        });
      }
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<UserModel> registerAccountInformations(
      UserModel userInformations) async {
    try {
      //Access the firestore collection for users
      CollectionReference userscollection =
          _firebaseFirestore.collection("users");

      //check if user already exist in Firestore
      DocumentSnapshot userSnapshot =
          await userscollection.doc(userInformations.id).get();

      if (!userSnapshot.exists) {
        //User doesn't exist in the Firestore, create a new document
        await userscollection.doc(userInformations.id).set({
          'full_name': userInformations.fullName,
          'phone_number': userInformations.phoneNumber,
          'passeword': hashPassword(userInformations.password),
        });
      }
      return userInformations;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<UserModel?> getUserInformationsFromGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential(credential);
        final User? user = authResult.user;
        return UserModel.fromFirebaseUserCredential(user);
      }
    } catch (error) {
      print(error);
      throw FirebaseExceptions(message: error.toString(), statusCode: 404);
    }
    return null;
  }
}
