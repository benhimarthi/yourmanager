import 'package:equatable/equatable.dart';

class Expenditure extends Equatable {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  const Expenditure({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  @override
  List<Object?> get props => [id];
}
