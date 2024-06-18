import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/users.dart';

abstract class UserAdminManagerRemoteDataSource {
  Future<Users> getUser(String id);
  Future<List<Users>> getAllUsers();
  Future<void> blacklistUser(String id);
  Future<void> deleteUserAccount(String id);
  Future<List<String>> getAllBlackLisetdUser();
}

class UserAdminManagerRemoteDataSourceImpl
    extends UserAdminManagerRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;

  UserAdminManagerRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> blacklistUser(String id) async {
    try {
      final docRef = _firebaseFirestore.collection('user_black_list');
      //Check if the user is already black listed, then unblacklisted him.
      final user = await docRef.where("user_id", isEqualTo: id).get();
      if (user.docs.isNotEmpty) {
        await _firebaseFirestore
            .collection('user_black_list')
            .doc(user.docs.first.id)
            .delete();
      } else {
        await docRef.add({'user_id': id});
      }
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> deleteUserAccount(String id) async {
    try {
      await _firebaseFirestore.collection('users').doc(id).delete();
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<Users>> getAllUsers() async {
    try {
      List<Users> result = [];
      final myUsersDocs = await _firebaseFirestore.collection('users').get();
      for (var n in myUsersDocs.docs) {
        result.add(UserModel.fromFirebaseFirestore(n));
      }
      return result;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<Users> getUser(String id) async {
    try {
      var myUserDoc =
          await _firebaseFirestore.collection('users').doc(id).get();
      return UserModel.fromFirebaseFirestore(myUserDoc);
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<String>> getAllBlackLisetdUser() async {
    try {
      List<String> myBlackListedUser = [];
      final result =
          await _firebaseFirestore.collection('user_black_list').get();
      for (var n in result.docs) {
        Map<String, dynamic> dt = n.data();
        myBlackListedUser.add(dt['user_id']);
      }
      return myBlackListedUser;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
