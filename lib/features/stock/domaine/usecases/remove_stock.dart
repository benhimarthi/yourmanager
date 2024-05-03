import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class RemoveStock extends UseCaseWithParam<void, String> {
  final StockRepository _repository;
  RemoveStock(this._repository);
  @override
  ResultFuture<void> call(String params) {
    return _repository.removeStock(params);
  }
}
