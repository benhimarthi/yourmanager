import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

class UserModel extends Users {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.password,
  });

  const UserModel.empty()
      : this(
          id: "_empty.ui",
          fullName: '_empty.fullName',
          phoneNumber: '_empty.phoneNumber',
          password: '_empty.password',
        );

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? password,
  }) {
    return UserModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password);
  }

  UserModel.fromMap(DataMap data)
      : this(
          id: data['id'] as String,
          fullName: data['fullName'] as String,
          phoneNumber: data['phoneNumber'] as String,
          password: data['password'] as String,
        );

  factory UserModel.fromFirebaseUserCredential(User? myUser) {
    return UserModel(
        id: myUser!.uid,
        fullName: myUser.displayName ?? "",
        phoneNumber: myUser.phoneNumber ?? "",
        password: "");
  }

  DataMap toMap() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'password': password,
      };
}
