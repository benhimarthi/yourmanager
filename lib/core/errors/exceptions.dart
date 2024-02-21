import 'package:equatable/equatable.dart';

class FirebaseExceptions extends Equatable implements Exception {
  final String message;
  final int statusCode;

  const FirebaseExceptions({required this.message, required this.statusCode});

  @override
  List<Object?> get props => [message, statusCode];
}
