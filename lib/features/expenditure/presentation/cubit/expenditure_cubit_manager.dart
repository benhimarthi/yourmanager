import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/expenditure/domain/usecases/delete_expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/usecases/get_all_expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/usecases/get_expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/usecases/register_expenditure.dart';
import 'package:yourmanager/features/expenditure/domain/usecases/update_expenditure.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_manager_state.dart';

class ExpenditureCubit extends Cubit<ExpenditureStateManager> {
  final RegisterExpenditure _registerExpenditure;
  final GetExpenditure _getExpenditure;
  final GetAllExpenditure _getAllExpenditure;
  final UpdateExpenditure _updateExpenditure;
  final DeleteExpenditure _deleteExpenditure;
  ExpenditureCubit({
    required RegisterExpenditure registerExpenditure,
    required GetExpenditure getExpenditure,
    required GetAllExpenditure getAllExpenditure,
    required UpdateExpenditure updateExpenditure,
    required DeleteExpenditure deleteExpenditure,
  })  : _registerExpenditure = registerExpenditure,
        _getExpenditure = getExpenditure,
        _getAllExpenditure = getAllExpenditure,
        _updateExpenditure = updateExpenditure,
        _deleteExpenditure = deleteExpenditure,
        super(const ExpenditureInitialState());

  Future<void> registerExpenditure(
    String title,
    double amount,
    DateTime date,
  ) async {
    emit(const IsRegisteringExpenditure());
    final result = await _registerExpenditure(RegisterExpenditureParams(
      title: title,
      amount: amount,
      date: date,
    ));
    result.fold(
      (failure) => emit(const ExpenditureRegisteredFailed(
          'A problem occured while trying to registered the expenditure.')),
      (id) => emit(ExpenditureRegisteredSuccessfully(id)),
    );
  }

  Future<void> getExpenditure(String id) async {
    emit(const IsGettingExpenditure());
    final result = await _getExpenditure(id);
    result.fold(
        (failure) => emit(
            const GetExpenditureFailed("we couldn't get the item requested.")),
        (expenditure) => emit(GetExpenditureSuccessfully(expenditure)));
  }

  Future<void> getAllExpenditures() async {
    emit(const IsGettingAllExpenditures());
    final result = await _getAllExpenditure();
    result.fold(
        (failure) => emit(const GetAllExpenditureFailed(
            "A problem occured while trying to get expenditures, please try againt.")),
        (expenditures) {
      emit(GetAllExpenditureSuccessfully(expenditures));
    });
  }

  Future<void> updateExpenditure(
    String id,
    String title,
    double amount,
    DateTime date,
  ) async {
    emit(const IsUpdatingExpenditure());
    final result = await _updateExpenditure(UpdateExpenditureParam(
      id: id,
      title: title,
      amount: amount,
      date: date,
    ));
    result.fold(
        (failure) => emit(const UpdateExpenditureFailed(
            "sorry, we couldn't changed the informations of the expenditure.")),
        (_) => emit(const UpdateExpenditureSuccessfully()));
  }

  Future<void> deleteExpenditure(String id) async {
    emit(const IsDeletingExpenditure());
    final result = await _deleteExpenditure(id);
    result.fold(
        (failure) => emit(const DeleteExpenditureFailed(
            "Sorry, a problem occured while trying to delete this item.")),
        (_) => emit(const DeleteExpenditureSuccessfully()));
  }
}
