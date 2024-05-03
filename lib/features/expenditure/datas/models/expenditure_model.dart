import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';

class ExpenditureModel extends Expenditure {
  const ExpenditureModel(
      {required super.id,
      required super.title,
      required super.amount,
      required super.date});

  factory ExpenditureModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ExpenditureModel(
      id: doc.id,
      title: data['title'] ?? "",
      amount: data['amount'] ?? "",
      date: DateTime.parse(data['date'] ?? ""),
    );
  }
}
