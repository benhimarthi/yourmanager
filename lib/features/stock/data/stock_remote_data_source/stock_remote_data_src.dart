import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/stock/data/models/stock_model.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

abstract class StockRemoteDataSource {
  Future<String> addItemsInStock(
    int itemNumber,
    String productId,
    String stockId,
    String userId,
  );
  Future<void> removeItemFromStock(int quantity, String stockId);
  Future<Stock> getStock(String id);
  Future<Stock> getStockById(String id);
  Future<List<Stock>> getAllStock();
  Future<void> removeStock(String stockId);
  Future<void> updateUserStock(
    String id,
    int quantity,
    int minQuantity,
    double stockCostPrice,
    double costPrice,
    double discount,
  );
  Future<void> setConfiguredValue(String id, bool value);
  Future<void> manageExpenditures(String id, String expenditureId, bool add);
}

class StockRemoteDataSourceImpl extends StockRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  StockRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<String> addItemsInStock(
    int itemNumber,
    String productId,
    String stockId,
    String userId,
  ) async {
    try {
      CollectionReference stockCollection =
          _firebaseFirestore.collection('stock');
      //Check if the document already exist in firestore
      DocumentSnapshot stockSnapshoot =
          await stockCollection.doc(stockId).get();
      if (stockSnapshoot.exists) {
        int currentQtt = stockSnapshoot.get('current_quantity');
        await stockCollection.doc(stockId).update({
          'quantity': currentQtt + itemNumber,
        });
        return stockSnapshoot.id;
      } else {
        final myStock = await _firebaseFirestore.collection("stock").add({
          'product_id': productId,
          'current_quantity': 0,
          'quantity': itemNumber,
          'min_quantity': 0,
          'user_id': userId,
          'stock_cost_price': 0,
          'cost_price': 0,
          'discount': 0,
          'configured': false,
          'expenditures': <String>[],
        });
        return myStock.id;
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
        var dt = stockSnapshoot.data() as Map<String, dynamic>;
        int currentQtt = dt['current_quantity'];
        if (quantity > currentQtt) {
          myStock.doc(stockId).update({'current_quantity': 0});
        } else {
          myStock
              .doc(stockId)
              .update({'current_quantity': currentQtt - quantity});
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

  @override
  Future<Stock> getStockById(String id) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('stock')
          .where('user_id', isEqualTo: id)
          .get();
      return StockModel.fromFireStore(querySnapshot.docs.first);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> updateUserStock(
    String id,
    int quantity,
    int minQuantity,
    double stockCostPrice,
    double costPrice,
    double discount,
  ) async {
    try {
      var myStock = await _firebaseFirestore.collection('stock').doc(id).get();
      var isConf = myStock.data()!['configured'];
      await _firebaseFirestore.collection('stock').doc(id).update({
        'quantity': quantity,
        'min_quantity': minQuantity,
        'stock_cost_price': stockCostPrice,
        'cost_price': costPrice,
        'discount': discount,
      });
      if (isConf == false) {
        await _firebaseFirestore.collection('stock').doc(id).update({
          'current_quantity': quantity,
        });
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> manageExpenditures(
    String id,
    String expenditureId,
    bool add,
  ) async {
    try {
      final myStock =
          await _firebaseFirestore.collection('stock').doc(id).get();
      List myExpenditures = await myStock.data()!['expenditures'];
      if (add) {
        myExpenditures.add(expenditureId);
      } else {
        if (myExpenditures.contains(expenditureId)) {
          myExpenditures.remove(expenditureId);
        }
      }
      await _firebaseFirestore.collection('stock').doc(id).update(
        {'expenditures': myExpenditures},
      );
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> setConfiguredValue(String id, bool value) async {
    try {
      await _firebaseFirestore
          .collection('stock')
          .doc(id)
          .update({'configured': value});
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
