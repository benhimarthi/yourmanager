import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class GetAllSale extends UseCaseWithoutParam<List<Sale>> {
  final SaleRepository _repository;
  GetAllSale(this._repository);
  @override
  ResultFuture<List<Sale>> call() {
    return _repository.getAllSales();
  }
}
