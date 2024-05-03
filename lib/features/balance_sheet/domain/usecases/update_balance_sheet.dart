import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class UpdateBalanceSheet
    extends UseCaseWithParam<void, UpdateBalanceSheetParam> {
  final BalanceSheetRepository _repository;
  const UpdateBalanceSheet(this._repository);

  @override
  ResultFuture<void> call(UpdateBalanceSheetParam params) {
    return _repository.updateBalanceSheet(
      params.id,
      params.saleId,
      params.expenditureId,
    );
  }
}

class UpdateBalanceSheetParam {
  final String id;
  final String saleId;
  final String expenditureId;
  UpdateBalanceSheetParam({
    required this.id,
    required this.saleId,
    required this.expenditureId,
  });
}
