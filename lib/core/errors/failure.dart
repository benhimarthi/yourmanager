import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:yourmanager/core/errors/exceptions.dart';

abstract class Failure extends Equatable {
  final String message;
  final int statusCode;

  String get errorMessage => "$statusCode Error: $message";
  const Failure({required this.statusCode, required this.message});

  @override
  List<Object> get props => [message, statusCode];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure({required super.statusCode, required super.message});
  FirebaseFailure.fromException(FirebaseExceptions exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
        );
}
