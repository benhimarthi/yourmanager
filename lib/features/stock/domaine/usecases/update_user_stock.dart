import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class UpdateUserStock extends UseCaseWithParam<void, UpdateUserStockParams> {
  final StockRepository _repository;

  UpdateUserStock(this._repository);

  @override
  ResultFuture<void> call(UpdateUserStockParams params) {
    return _repository.updateUserStock(
      params.id,
      params.quantity,
      params.minQuantity,
      params.stockCostPrice,
      params.costPrice,
      params.discount,
    );
  }
}

class UpdateUserStockParams {
  final String id;
  final int quantity;
  final int minQuantity;
  final double stockCostPrice;
  final double costPrice;
  final double discount;
  UpdateUserStockParams({
    required this.id,
    required this.quantity,
    required this.minQuantity,
    required this.stockCostPrice,
    required this.costPrice,
    required this.discount,
  });
}
