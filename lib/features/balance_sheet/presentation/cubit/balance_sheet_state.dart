import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';

class BalanceSheetState extends Equatable {
  const BalanceSheetState();
  @override
  List<Object?> get props => [];
}

class BalanceSheetInitial extends BalanceSheetState {
  const BalanceSheetInitial();
}

class BalanceSheetCreatedSuccessfully extends BalanceSheetState {
  const BalanceSheetCreatedSuccessfully();
}

class BalanceSheetCreationFailed extends BalanceSheetState {
  final String message;
  const BalanceSheetCreationFailed(this.message);
}

class GetBalanceSheetSuccessfully extends BalanceSheetState {
  final BalanceSheet balanceSheet;
  const GetBalanceSheetSuccessfully(this.balanceSheet);
}

class GetBalanceSheetFailed extends BalanceSheetState {
  final String message;
  const GetBalanceSheetFailed(this.message);
}

class GetAllBalanceSheetSuccessfully extends BalanceSheetState {
  final List<BalanceSheet> myBalanceSheet;
  const GetAllBalanceSheetSuccessfully(this.myBalanceSheet);
}

class GetAllBalanceSheetFailed extends BalanceSheetState {
  final String message;
  const GetAllBalanceSheetFailed(this.message);
}

class UpdateBalanceSheetSuccessfully extends BalanceSheetState {
  const UpdateBalanceSheetSuccessfully();
}

class UpdateBalanceSheetFailed extends BalanceSheetState {
  final String message;
  const UpdateBalanceSheetFailed(this.message);
}

class DeleteBalanceSheetSuccessfully extends BalanceSheetState {
  const DeleteBalanceSheetSuccessfully();
}

class DeleteBalanceSheetFailed extends BalanceSheetState {
  final String message;
  const DeleteBalanceSheetFailed(this.message);
}
