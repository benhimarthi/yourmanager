import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class GetExpenditure extends UseCaseWithParam<Expenditure, String> {
  final ExpenditureRepository _repository;
  GetExpenditure(this._repository);
  @override
  ResultFuture<Expenditure> call(String params) {
    return _repository.getExpenditure(params);
  }
}
