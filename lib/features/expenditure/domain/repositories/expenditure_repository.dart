import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';

abstract class ExpenditureRepository {
  ResultVoid registerExpenditure(
    String title,
    double amount,
    DateTime date,
  );
  ResultFuture<Expenditure> getExpenditure(String id);
  ResultFuture<List<Expenditure>> getAllExpenditure();
  ResultVoid updateExpenditure(
    String id,
    String title,
    double amount,
    DateTime date,
  );
  ResultVoid deleteExpenditure(String id);
}
