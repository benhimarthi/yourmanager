import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String productId;
  final String userId;
  final int quantity;

  const Stock({
    required this.id,
    required this.productId,
    required this.userId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [id, productId, userId];
}
