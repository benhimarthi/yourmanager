import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/authentication/domain/entities/users.dart';

class UserModel extends Users {
  const UserModel({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.image,
    required super.email,
  });

  UserModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? image,
    String? email,
  }) {
    return UserModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      email: email ?? this.email,
    );
  }

  UserModel.fromMap(DataMap data)
      : this(
          id: data['id'] as String,
          fullName: data['fullName'] as String,
          phoneNumber: data['phoneNumber'] as String,
          image: data['image'] as String,
          email: data['email'] as String,
        );

  factory UserModel.fromFirebaseUserCredential(User? myUser) {
    return UserModel(
      id: myUser!.uid,
      fullName: myUser.displayName ?? "",
      phoneNumber: myUser.phoneNumber ?? "",
      image: myUser.photoURL ?? '',
      email: myUser.email ?? '',
    );
  }

  factory UserModel.fromFirebaseFirestore(DocumentSnapshot myUser) {
    Map<String, dynamic> myDatas = myUser.data() as Map<String, dynamic>;
    return UserModel(
      id: myUser.id,
      fullName: myDatas['full_name'],
      phoneNumber: myDatas['phone_number'],
      image: myDatas['image'],
      email: myDatas['email'],
    );
  }

  DataMap toMap() => {
        'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'image': image,
        'email': email,
      };
}
