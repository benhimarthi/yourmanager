import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/repositories/balance_sheet_repository.dart';

class GetAllBalanceSheet extends UseCaseWithoutParam<List<BalanceSheet>> {
  final BalanceSheetRepository _repository;
  const GetAllBalanceSheet(this._repository);
  @override
  ResultFuture<List<BalanceSheet>> call() {
    return _repository.getAllBalanceSheet();
  }
}
