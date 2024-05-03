import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/repositories/expenditure_repository.dart';

class GetAllExpenditure extends UseCaseWithoutParam<List<Expenditure>> {
  final ExpenditureRepository _repository;
  GetAllExpenditure(this._repository);
  @override
  ResultFuture<List<Expenditure>> call() {
    return _repository.getAllExpenditure();
  }
}
