import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository.dart';

class ManageExpenditure
    extends UseCaseWithParam<void, ManageExpenditureParams> {
  final StockRepository _repository;
  ManageExpenditure(this._repository);

  @override
  ResultFuture<void> call(ManageExpenditureParams params) {
    return _repository.manageExpenditure(
      params.productId,
      params.expenditureId,
      params.add,
    );
  }
}

class ManageExpenditureParams {
  final String productId;
  final String expenditureId;
  final bool add;
  ManageExpenditureParams(
    this.productId,
    this.expenditureId,
    this.add,
  );
}
