import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class RegisterExpenditure
    extends UseCaseWithParam<void, RegisterExpenditureParams> {
  final ExpenditureRepository _repository;
  RegisterExpenditure(this._repository);
  @override
  ResultFuture<void> call(RegisterExpenditureParams params) {
    return _repository.registerExpenditure(
      params.title,
      params.amount,
      params.date,
    );
  }
}

class RegisterExpenditureParams {
  final String title;
  final double amount;
  final DateTime date;
  const RegisterExpenditureParams({
    required this.title,
    required this.amount,
    required this.date,
  });
}
