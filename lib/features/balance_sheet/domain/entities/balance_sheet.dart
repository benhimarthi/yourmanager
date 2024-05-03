import 'package:equatable/equatable.dart';

class BalanceSheet extends Equatable {
  final String id;
  final double income;
  final double expenditure;
  final double benefit;
  final DateTime date;
  final List<dynamic> saleHistory;
  final List<dynamic> expenditureHistory;

  const BalanceSheet({
    required this.id,
    required this.income,
    required this.expenditure,
    required this.benefit,
    required this.date,
    required this.saleHistory,
    required this.expenditureHistory,
  });

  @override
  List<Object?> get props => [id];
}
