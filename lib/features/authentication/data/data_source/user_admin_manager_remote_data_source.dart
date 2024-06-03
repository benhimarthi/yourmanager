import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/authentication/data/models/user_model.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/entities/users.dart';

abstract class UserAdminManagerRemoteDataSource {
  Future<Users> getUser(String id);
  Future<List<Users>> getAllUsers();
  Future<void> blacklistUser(String id);
  Future<void> deleteUserAccount(String id);
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
        Map<String, dynamic> data = n as Map<String, dynamic>;
        result.add(UserModel.fromMap(data));
      }
      return result;
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<Users> getUser(String id) async {
    try {
      var myUserDoc = _firebaseFirestore.collection('users').doc(id);
      var asMap = myUserDoc as Map<String, dynamic>;
      return UserModel.fromMap(asMap);
    } catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
