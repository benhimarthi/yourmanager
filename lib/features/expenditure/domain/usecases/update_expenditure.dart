import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class UpdateExpenditure extends UseCaseWithParam<void, UpdateExpenditureParam> {
  final ExpenditureRepository _repository;
  UpdateExpenditure(this._repository);
  @override
  ResultFuture<void> call(UpdateExpenditureParam params) {
    return _repository.updateExpenditure(
      params.id,
      params.title,
      params.amount,
      params.date,
    );
  }
}

class UpdateExpenditureParam {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  UpdateExpenditureParam({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
  });
}
