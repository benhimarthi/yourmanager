import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String productId;
  final String userId;
  final int currentQuantity;
  final int quantity;
  final int minQuantity;
  final double stockCostPrice;
  final double costPrice;
  final double discount;
  final bool configured;
  final List<dynamic> expenditures;

  const Stock({
    required this.id,
    required this.productId,
    required this.userId,
    required this.currentQuantity,
    required this.quantity,
    required this.minQuantity,
    required this.stockCostPrice,
    required this.costPrice,
    required this.discount,
    required this.configured,
    required this.expenditures,
  });

  @override
  List<Object?> get props => [id, productId, userId];
}
