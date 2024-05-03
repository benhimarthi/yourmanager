import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class GetStock extends UseCaseWithParam<Stock, String> {
  final StockRepository _repository;
  GetStock(this._repository);
  @override
  ResultFuture<Stock> call(String params) {
    return _repository.getStock(params);
  }
}
