import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/expenditure/datas/models/expenditure_model.dart';

abstract class ExpenditureRemoteDataSource {
  Future<void> registerExpenditure(
    String title,
    double amount,
    DateTime date,
  );
  Future<ExpenditureModel> getExpenditure(String id);
  Future<List<ExpenditureModel>> getAllExpenditure();
  Future<void> updateExpenditure(
    String id,
    String title,
    double amount,
    DateTime date,
  );
  Future<void> deleteExpenditure(String id);
}

class ExpenditureRemoteDataSourceImpl extends ExpenditureRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  ExpenditureRemoteDataSourceImpl(this._firebaseFirestore);

  @override
  Future<void> deleteExpenditure(String id) async {
    try {
      await _firebaseFirestore.collection('expenditure').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<ExpenditureModel>> getAllExpenditure() async {
    List<ExpenditureModel> expenditures = [];
    try {
      final result = await _firebaseFirestore.collection('expenditure').get();
      for (var doc in result.docs) {
        expenditures.add(ExpenditureModel.fromFirestore(doc));
      }
      return expenditures;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<ExpenditureModel> getExpenditure(String id) async {
    try {
      final exp =
          await _firebaseFirestore.collection('expenditure').doc(id).get();
      return ExpenditureModel.fromFirestore(exp);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> registerExpenditure(
      String title, double amount, DateTime date) async {
    try {
      await _firebaseFirestore.collection('expenditure').add({
        'title': title,
        'amount': amount,
        'date': date,
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> updateExpenditure(
      String id, String title, double amount, DateTime date) async {
    try {
      await _firebaseFirestore.collection("expenditure").doc(id).update({
        'title': title,
        'amount': amount,
        'date': date,
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
