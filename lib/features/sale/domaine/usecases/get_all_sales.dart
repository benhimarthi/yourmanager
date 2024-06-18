import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class GetAllSale extends UseCaseWithParam<List<Sale>, String> {
  final SaleRepository _repository;
  GetAllSale(this._repository);
  @override
  ResultFuture<List<Sale>> call(String params) {
    return _repository.getAllSales(params);
  }
}
