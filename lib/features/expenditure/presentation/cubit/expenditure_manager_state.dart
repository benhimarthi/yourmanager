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

class ExpenditureRegisteredSuccessfully extends ExpenditureStateManager {
  const ExpenditureRegisteredSuccessfully();
}

class ExpenditureRegisteredFailed extends ExpenditureStateManager {
  final String message;
  const ExpenditureRegisteredFailed(this.message);
}

class GetExpenditureSuccessfully extends ExpenditureStateManager {
  final Expenditure expenditure;
  const GetExpenditureSuccessfully(this.expenditure);
}

class GetExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const GetExpenditureFailed(this.message);
}

class GetAllExpenditureSuccessfully extends ExpenditureStateManager {
  final List<Expenditure> expenditures;
  const GetAllExpenditureSuccessfully(this.expenditures);
}

class GetAllExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const GetAllExpenditureFailed(this.message);
}

class UpdateExpenditureSuccessfully extends ExpenditureStateManager {
  const UpdateExpenditureSuccessfully();
}

class UpdateExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const UpdateExpenditureFailed(this.message);
}

class DeleteExpenditureSuccessfully extends ExpenditureStateManager {
  const DeleteExpenditureSuccessfully();
}

class DeleteExpenditureFailed extends ExpenditureStateManager {
  final String message;
  const DeleteExpenditureFailed(this.message);
}
