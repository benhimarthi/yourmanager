import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/balance_sheet/domain/usecases/create_balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/usecases/delete_balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/usecases/get_all_balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/usecases/get_balance_sheet.dart';
import 'package:yourmanager/features/balance_sheet/domain/usecases/update_balance_sheet.dart';
import 'balance_sheet_state.dart';

class BalanceSheetCubit extends Cubit<BalanceSheetState> {
  final CreateBalanceSheet _createBalanceSheet;
  final GetBalanceSheet _getBalanceSheet;
  final GetAllBalanceSheet _getAllBalanceSheet;
  final UpdateBalanceSheet _updateBalanceSheet;
  final DeleteBalanceSheet _deleteBalanceSheet;
  BalanceSheetCubit({
    required CreateBalanceSheet createBalanceSheet,
    required GetBalanceSheet getBalanceSheet,
    required GetAllBalanceSheet getAllBalanceSheet,
    required UpdateBalanceSheet updateBalanceSheet,
    required DeleteBalanceSheet deleteBalanceSheet,
  })  : _createBalanceSheet = createBalanceSheet,
        _getBalanceSheet = getBalanceSheet,
        _getAllBalanceSheet = getAllBalanceSheet,
        _updateBalanceSheet = updateBalanceSheet,
        _deleteBalanceSheet = deleteBalanceSheet,
        super(const BalanceSheetInitial());
  Future<void> createBalanceSheet(
    DateTime date,
    String saleId,
    String expenditureId,
  ) async {
    final result = await _createBalanceSheet(CreateBalanceSheetParam(
      date: date,
      saleId: saleId,
      expenditureId: expenditureId,
    ));
    result.fold(
        (failure) => emit(const BalanceSheetCreationFailed(
            "somethig went wrong while trying to create the balance sheet")),
        (_) => emit(const BalanceSheetCreatedSuccessfully()));
  }

  Future<void> getBalanceSheet(String id) async {
    final result = await _getBalanceSheet(id);
    result.fold(
        (failure) => emit(
            const GetBalanceSheetFailed("we couldn't get this balance sheet.")),
        (balanceSheet) => emit(GetBalanceSheetSuccessfully(balanceSheet)));
  }

  Future<void> getAllBalanceSheet() async {
    final result = await _getAllBalanceSheet();
    result.fold(
        (failure) => emit(
            const GetAllBalanceSheetFailed("we couldn't the balance sheets.")),
        (balanceSheet) => emit(GetAllBalanceSheetSuccessfully(balanceSheet)));
  }

  Future<void> updateBalanceSheet(
    String id,
    String saleId,
    String expenditureId,
  ) async {
    final result = await _updateBalanceSheet(UpdateBalanceSheetParam(
        id: id, saleId: saleId, expenditureId: expenditureId));
    result.fold(
        (failure) => emit(const UpdateBalanceSheetFailed(
            "we couldn't update your new informations please try again.")),
        (_) => const UpdateBalanceSheetSuccessfully());
  }

  Future<void> deleteBalanceSheet(String id) async {
    final result = await _deleteBalanceSheet(id);
    result.fold(
        (failure) => emit(const DeleteBalanceSheetFailed(
            "we couldn't delete this balance sheet, please try again.")),
        (_) => const DeleteBalanceSheetSuccessfully());
  }
}
