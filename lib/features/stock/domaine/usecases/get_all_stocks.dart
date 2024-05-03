import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class GetAllStock extends UseCaseWithoutParam<List<Stock>> {
  final StockRepository _repository;
  GetAllStock(this._repository);
  @override
  ResultFuture<List<Stock>> call() {
    return _repository.getAllStock();
  }
}
