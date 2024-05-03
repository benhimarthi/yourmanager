import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/balance_sheet/datas/models/balance_sheet_model.dart';
import 'package:yourmanager/features/balance_sheet/domain/entities/balance_sheet.dart';

abstract class BalanceSheetRemoteDataSource {
  Future<void> createBalanceSheet(
    DateTime date,
    String saleId,
    String expenditureId,
  );
  Future<BalanceSheet> getBalanceSheet(String id);
  Future<List<BalanceSheet>> getAllBalanceSheet();
  Future<void> updateBalanceSheet(
      String id, String saleId, String expenditureId);
  Future<void> deleteBalance(String id);
}

class BalanceSheetRemoteDataSourceImpl extends BalanceSheetRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  BalanceSheetRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> createBalanceSheet(
      DateTime date, String saleId, String expenditureId) async {
    try {
      List<String> sales = [];
      if (saleId.isNotEmpty) {
        sales.add(saleId);
      }
      List<String> expenditures = [];
      if (expenditureId.isNotEmpty) {
        expenditures.add(expenditureId);
      }
      await _firebaseFirestore.collection('balance_sheet').add({
        'income': 0,
        'expenditure': 0,
        'benefit': 0,
        'date': date.toString(),
        'sale_history': sales,
        'expenditure_history': expenditures,
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<void> deleteBalance(String id) async {
    try {
      await _firebaseFirestore.collection('balance_sheet').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<List<BalanceSheet>> getAllBalanceSheet() async {
    try {
      List<BalanceSheet> result = [];
      final myBalances =
          await _firebaseFirestore.collection('balance_sheet').get();
      for (var n in myBalances.docs) {
        result.add(BalanceSheetModel.fromFirestore(n));
      }
      return result;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<BalanceSheet> getBalanceSheet(String id) async {
    try {
      final balance =
          await _firebaseFirestore.collection('balance_sheet').doc(id).get();
      return BalanceSheetModel.fromFirestore(balance);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<void> updateBalanceSheet(
      String id, String saleId, String expenditureId) async {
    try {
      final initial =
          await _firebaseFirestore.collection('balance_sheet').doc(id).get();

      if (saleId.isNotEmpty) {
        List<dynamic> sales = initial.get('sale_history');
        sales.add(saleId);
      } else if (expenditureId.isNotEmpty) {
        List<dynamic> expenditures = initial.get('expenditure_history');
        expenditures.add(expenditureId);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }
}
