import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class DeleteSale extends UseCaseWithParam<void, String> {
  final SaleRepository _repository;
  DeleteSale(this._repository);
  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteSale(params);
  }
}
