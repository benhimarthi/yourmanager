import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';

class BalanceSheetModel extends BalanceSheet {
  const BalanceSheetModel({
    required super.id,
    required super.income,
    required super.expenditure,
    required super.benefit,
    required super.date,
    required super.saleHistory,
    required super.expenditureHistory,
  });
  factory BalanceSheetModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return BalanceSheetModel(
      id: data['id'] ?? "",
      income: data['income'] ?? 0,
      expenditure: data['expenditure'] ?? 0,
      benefit: data['benefit'] ?? 0,
      date: DateTime.parse(data['date'] ?? ""),
      saleHistory: data['saleHistory'] ?? List<dynamic>,
      expenditureHistory: data['expenditureHistory'] ?? List<dynamic>,
    );
  }
}
