import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String password;

  const Users(
      {required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.password});

  const Users.empty()
      : this(
          id: '_empty.uid',
          fullName: '_empty.fullName',
          phoneNumber: '_empty.phoneNumber',
          password: '_empty.password',
        );

  @override
  List<Object?> get props => [id, phoneNumber];
}
