import 'package:equatable/equatable.dart';

class Stock extends Equatable {
  final String id;
  final String productId;
  final int quantity;
  const Stock({
    required this.id,
    required this.productId,
    required this.quantity,
  });
  const Stock.empty()
      : this(
          id: "_empty.id",
          productId: "_empty.productId",
          quantity: 0,
        );

  @override
  List<Object?> get props => [id, productId];
}
