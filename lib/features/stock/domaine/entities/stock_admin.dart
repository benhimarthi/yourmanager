import 'package:equatable/equatable.dart';

class StockAdmin extends Equatable {
  final String id;
  final String productId;
  final List<dynamic> usersId;
  final bool isAble;

  const StockAdmin({
    required this.id,
    required this.productId,
    required this.usersId,
    required this.isAble,
  });

  @override
  List<Object?> get props => [id];
}
