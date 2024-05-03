import 'package:equatable/equatable.dart';

class Sale extends Equatable {
  final String id;
  final String productId;
  final int quantity;
  final DateTime date;
  const Sale({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.date,
  });
  @override
  List<Object?> get props => [id];
}
