import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class RemoveItemFromStock
    extends UseCaseWithParam<void, RemoveItemFromInventoryParam> {
  final StockRepository _repository;
  RemoveItemFromStock(this._repository);
  @override
  ResultFuture<void> call(RemoveItemFromInventoryParam params) {
    return _repository.removeItemFromStock(params.quantity, params.stockId);
  }
}

class RemoveItemFromInventoryParam {
  final int quantity;
  final String stockId;
  RemoveItemFromInventoryParam({required this.quantity, required this.stockId});
}
