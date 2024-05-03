import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class DeleteExpenditure extends UseCaseWithParam<void, String> {
  final ExpenditureRepository _repository;
  DeleteExpenditure(this._repository);

  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteExpenditure(params);
  }
}
