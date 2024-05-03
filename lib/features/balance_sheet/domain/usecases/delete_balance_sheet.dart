import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class DeleteBalanceSheet extends UseCaseWithParam<void, String> {
  final BalanceSheetRepository _repository;
  const DeleteBalanceSheet(this._repository);
  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteBalance(params);
  }
}
