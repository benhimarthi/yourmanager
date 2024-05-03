import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class GetBalanceSheet extends UseCaseWithParam<BalanceSheet, String> {
  final BalanceSheetRepository _repository;
  const GetBalanceSheet(this._repository);

  @override
  ResultFuture<BalanceSheet> call(String params) {
    return _repository.getBalanceSheet(params);
  }
}
