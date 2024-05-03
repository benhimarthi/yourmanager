import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/sale/data/models/sale_model.dart';

import '../../domaine/entities/sale.dart';

abstract class SaleRemoteDataSource {
  Future<void> registerSale(
    String productId,
    int quantity,
    DateTime date,
  );
  Future<void> deleteSale(String id);
  Future<Sale> getSale(String saleId);
  Future<List<Sale>> getAllSales();
}

class SaleRemoteDataSourceImpl extends SaleRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  SaleRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> deleteSale(String id) async {
    try {
      await _firebaseFirestore.collection('sales').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<Sale>> getAllSales() async {
    try {
      List<Sale> sales = [];
      final dbSale = await _firebaseFirestore.collection('sales').get();
      for (var s in dbSale.docs) {
        sales.add(SaleModel.fromFirestore(s));
      }
      return sales;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<Sale> getSale(String saleId) async {
    try {
      final saleItem =
          await _firebaseFirestore.collection('sales').doc(saleId).get();
      return SaleModel.fromFirestore(saleItem);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> registerSale(
      String productId, int quantity, DateTime date) async {
    try {
      await _firebaseFirestore.collection('sales').add({
        'product_id': productId,
        'quantity': quantity,
        'date': DateTime.now().toString(),
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
