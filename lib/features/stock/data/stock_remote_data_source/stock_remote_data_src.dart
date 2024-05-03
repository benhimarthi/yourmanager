import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/stock/data/models/stock_model.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

abstract class StockRemoteDataSource {
  Future<void> addItemsInStock(
      int itemNumber, String productId, String stockId);
  Future<void> removeItemFromStock(int quantity, String stockId);
  Future<Stock> getStock(String id);
  Future<List<Stock>> getAllStock();
  Future<void> removeStock(String stockId);
}

class StockRemoteDataSourceImpl extends StockRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  StockRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> addItemsInStock(
      int itemNumber, String productId, String stockId) async {
    try {
      CollectionReference stockCollection =
          _firebaseFirestore.collection('stock');
      //Check if the document already exist in firestore
      DocumentSnapshot stockSnapshoot =
          await stockCollection.doc(stockId).get();
      if (stockSnapshoot.exists) {
        int currentQtt = stockSnapshoot.get('quantity');
        await stockCollection.doc(stockId).update({
          'quantity': currentQtt + itemNumber,
        });
      } else {
        await _firebaseFirestore.collection("stock").add({
          'product_id': productId,
          'quantity': itemNumber,
        });
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> removeItemFromStock(int quantity, String stockId) async {
    try {
      CollectionReference myStock = _firebaseFirestore.collection('stock');
      DocumentSnapshot stockSnapshoot = await myStock.doc(stockId).get();
      if (stockSnapshoot.exists) {
        int currentQtt = stockSnapshoot.get('quantity');
        if (quantity > currentQtt) {
          myStock.doc(stockId).update({'quantity': 0});
        } else {
          myStock.doc(stockId).update({'quantity': currentQtt - quantity});
        }
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<Stock>> getAllStock() async {
    try {
      List<Stock> result = [];
      QuerySnapshot myStocks =
          await _firebaseFirestore.collection('stock').get();
      for (var doc in myStocks.docs) {
        result.add(StockModel.fromFireStore(doc));
      }
      return result;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<Stock> getStock(String id) async {
    try {
      DocumentSnapshot stock =
          await _firebaseFirestore.collection('stock').doc(id).get();
      if (stock.exists) {
        return StockModel.fromFireStore(stock);
      } else {
        throw const FirebaseExceptions(
            message: "We couldn't get this object.", statusCode: 404);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> removeStock(String stockId) async {
    try {
      await _firebaseFirestore.collection('stock').doc(stockId).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
