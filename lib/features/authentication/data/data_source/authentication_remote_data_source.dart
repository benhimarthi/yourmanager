import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/core/errors/failure.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entities/users.dart';

abstract class AuthenticationRemoteDataSrc {
  Future<UserModel> login(
      String verificationId, String smsCode, String password);

  Future<void> verifyPhoneNumber(
    String phoneNumber,
    Function(String) onCodeSent,
    Function(Failure) onVerificationFailed,
    Function(String) onVerificationCompleted,
  );

  Future<void> updateUserInformations(
    String id,
    String fullName,
    String image,
    String phoneNumber,
  );
  Future<UserModel> registerAccountInformations(UserModel userInformations);
  Future<UserModel?> getUserInformationsFromGoogle();
  Future<UserCredential> createAccountWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserCredential> loginWithEmailAndPassword(
    String email,
    String password,
  );
  Future<UserModel> getUser(String id);
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
  Future<void> updateUserInformations(
    String id,
    String fullName,
    String image,
    String phoneNumber,
  ) async {
    try {
      //Access the firestore collection for users
      CollectionReference userscollection =
          _firebaseFirestore.collection("users");
      //check if user already exist in Firestore
      DocumentSnapshot userSnapshot = await userscollection.doc(id).get();

      if (userSnapshot.exists) {
        var myData = userSnapshot.data() as Map<String, dynamic>;
        await userscollection.doc(id).update({
          'full_name': fullName.isNotEmpty ? fullName : myData['full_name'],
          'phone_number':
              phoneNumber.isNotEmpty ? phoneNumber : myData['phone_number'],
          'image': image.isNotEmpty ? image : myData['image'],
        });
      }
    } catch (e) {
      throw FirebaseExceptions(
        message: e.toString(),
        statusCode: 404,
      );
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
          'image': userInformations.image,
          'email': userInformations.email,
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
      throw FirebaseExceptions(message: error.toString(), statusCode: 404);
    }
    return null;
  }

  @override
  Future<UserCredential> createAccountWithEmailAndPassword(
      String email, String password) async {
    try {
      final isUserExist = await _firebaseFirestore
          .collection('users')
          .where(
            'email',
            isEqualTo: email,
          )
          .get();

      if (isUserExist.docs.isNotEmpty) {
        throw const FirebaseExceptions(
            message: 'This user already exist!, try to log in.',
            statusCode: 500);
      } else {
        UserCredential userCred =
            await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCred;
      }
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      var isUserBlackListed = await _firebaseFirestore
          .collection('user_black_list')
          .where('user_id', isEqualTo: userCredential.user!.uid)
          .get();
      if (isUserBlackListed.docs.isNotEmpty) {
        throw const FirebaseExceptions(
            message:
                "Sorry, Your account has been black listed, contact the administrator to resolve this issue.",
            statusCode: 501);
      }
      return userCredential;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<UserModel> getUser(String id) async {
    try {
      var myUserDoc =
          await _firebaseFirestore.collection('users').doc(id).get();
      return UserModel.fromFirebaseFirestore(myUserDoc);
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
