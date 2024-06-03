import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String image;
  final String email;

  const Users({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.image,
    required this.email,
  });

  @override
  List<Object?> get props => [id];
}
