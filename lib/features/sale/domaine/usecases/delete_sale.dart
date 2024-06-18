import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class DeleteSale extends UseCaseWithParam<void, DeleteSaleParam> {
  final SaleRepository _repository;
  DeleteSale(this._repository);
  @override
  ResultFuture<void> call(DeleteSaleParam params) {
    return _repository.deleteSale(params.userId, params.id);
  }
}

class DeleteSaleParam {
  final String id;
  final String userId;

  DeleteSaleParam(this.id, this.userId);
}
