import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class GetSale extends UseCaseWithParam<Sale, GetSaleParams> {
  final SaleRepository _repository;
  GetSale(this._repository);
  @override
  ResultFuture<Sale> call(GetSaleParams params) {
    return _repository.getSale(params.userId, params.saleId);
  }
}

class GetSaleParams {
  final String saleId;
  final String userId;
  GetSaleParams(this.saleId, this.userId);
}
