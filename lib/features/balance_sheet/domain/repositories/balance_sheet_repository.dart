import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';

abstract class BalanceSheetRepository {
  ResultVoid createBalanceSheet(
    DateTime date,
    String saleId,
    String expenditureId,
  );
  ResultFuture<BalanceSheet> getBalanceSheet(String id);
  ResultFuture<List<BalanceSheet>> getAllBalanceSheet();
  ResultVoid updateBalanceSheet(
    String id,
    String saleId,
    String expenditureId,
  );
  ResultVoid deleteBalance(String id);
}
