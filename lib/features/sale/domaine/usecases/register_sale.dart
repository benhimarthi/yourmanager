import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/repositories/sale_repository.dart';

class RegisterSale extends UseCaseWithParam<void, RegisterSaleParams> {
  final SaleRepository _repository;
  RegisterSale(this._repository);
  @override
  ResultFuture<void> call(RegisterSaleParams params) {
    return _repository.registerSale(
      params.productId,
      params.quantity,
      params.date,
    );
  }
}

class RegisterSaleParams {
  final String productId;
  final int quantity;
  final DateTime date;
  RegisterSaleParams({
    required this.productId,
    required this.quantity,
    required this.date,
  });
}
