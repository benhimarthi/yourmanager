import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:yourmanager/features/authentication/data/data_source/authentication_remote_data_source.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {}

void main() {
  FirebaseAuth firebaseAuth;
  AuthenticationRemoteDataSrcImpl auth;

  setUp(() {
    firebaseAuth = FirebaseAuthMock();
    auth = AuthenticationRemoteDataSrcImpl(firebaseAuth);
  });

  group(
      "should complete successfully when the status code is 200 or 201", () {});
}
