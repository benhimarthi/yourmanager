import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';

class ExpenditureStateManager extends Equatable {
  const ExpenditureStateManager();
  @override
  List<Object?> get props => [];
}

class ExpenditureInitialState extends ExpenditureStateManager {
  const ExpenditureInitialState();
}

class IsRegisteringExpenditure extends ExpenditureStateManager {
  const IsRegisteringExpenditure();
}

class ExpenditureRegisteredSuccessfully extends ExpenditureStateManager {
  final String expenditureId;
  const ExpenditureRegisteredSuccessfully(this.expenditureId);
}

class ExpenditureRegisteredFailed extends ExpenditureStateManager {
  final String message;
  const ExpenditureRegisteredFailed(this.message);
}

class IsGettingExpenditure extends ExpenditureStateManager {
  const IsGettingExpenditure();
}

class GetExpenditureSuccessfully extends ExpenditureStateManager {
  final Expenditure expenditure;
  const GetExpenditureSuccessfully(this.expenditure);
}

class GetExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const GetExpenditureFailed(this.message);
}

class IsGettingAllExpenditures extends ExpenditureStateManager {
  const IsGettingAllExpenditures();
}

class GetAllExpenditureSuccessfully extends ExpenditureStateManager {
  final List<Expenditure> expenditures;
  const GetAllExpenditureSuccessfully(this.expenditures);
}

class GetAllExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const GetAllExpenditureFailed(this.message);
}

class IsUpdatingExpenditure extends ExpenditureStateManager {
  const IsUpdatingExpenditure();
}

class UpdateExpenditureSuccessfully extends ExpenditureStateManager {
  const UpdateExpenditureSuccessfully();
}

class UpdateExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const UpdateExpenditureFailed(this.message);
}

class IsDeletingExpenditure extends ExpenditureStateManager {
  const IsDeletingExpenditure();
}

class DeleteExpenditureSuccessfully extends ExpenditureStateManager {
  const DeleteExpenditureSuccessfully();
}

class DeleteExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const DeleteExpenditureFailed(this.message);
}
