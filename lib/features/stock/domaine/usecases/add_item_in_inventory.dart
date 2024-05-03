import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class AddItemInInventory extends UseCaseWithParam<void, AddItemInStockParam> {
  final StockRepository _repository;
  AddItemInInventory(this._repository);
  @override
  ResultFuture<void> call(AddItemInStockParam params) {
    return _repository.addItemsInStock(
        params.quantity, params.productId, params.stockId);
  }
}

class AddItemInStockParam {
  final int quantity;
  final String productId;
  final String stockId;
  AddItemInStockParam({
    required this.quantity,
    required this.productId,
    required this.stockId,
  });
}
