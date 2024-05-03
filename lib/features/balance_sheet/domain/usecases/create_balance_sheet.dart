import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class CreateBalanceSheet
    extends UseCaseWithParam<void, CreateBalanceSheetParam> {
  final BalanceSheetRepository _repository;
  const CreateBalanceSheet(this._repository);

  @override
  ResultFuture<void> call(CreateBalanceSheetParam params) {
    return _repository.createBalanceSheet(
      params.date,
      params.saleId,
      params.expenditureId,
    );
  }
}

class CreateBalanceSheetParam {
  final DateTime date;
  final String saleId;
  final String expenditureId;
  CreateBalanceSheetParam({
    required this.date,
    required this.saleId,
    required this.expenditureId,
  });
}
