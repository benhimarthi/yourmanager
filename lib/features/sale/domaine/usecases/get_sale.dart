import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class GetSale extends UseCaseWithParam<Sale, String> {
  final SaleRepository _repository;
  GetSale(this._repository);
  @override
  ResultFuture<Sale> call(String params) {
    return _repository.getSale(params);
  }
}
