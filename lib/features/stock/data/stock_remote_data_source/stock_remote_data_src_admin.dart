import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/stock/data/models/stock_model_admin.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domaine/entities/stock_admin.dart';

abstract class StockRemoteDataSourceAdmin {
  Future<void> createNewProductStock(String productId);
  Future<StockAdmin> getProductStock(String id);
  Future<StockAdmin> getProductStockByProductId(String id);
  Future<List<StockAdmin>> getAllProductStock();
  Future<void> removeProductStock(String id);
  Future<void> updateProduct(
    String stockId,
    String userId,
    bool isNewUser, {
    bool isAble = true,
  });
}

class StockRemoteDataSourceImpl extends StockRemoteDataSourceAdmin {
  final FirebaseFirestore _firebaseFirestore;

  StockRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> createNewProductStock(String productId) async {
    try {
      await _firebaseFirestore.collection("stock_admin").add({
        'product_id': productId,
        'users_id': [],
        'is_able': true,
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<StockAdmin>> getAllProductStock() async {
    try {
      List<StockAdmin> result = [];
      QuerySnapshot myStocks =
          await _firebaseFirestore.collection('stock_admin').get();
      for (var doc in myStocks.docs) {
        result.add(StockModelAdmin.fromFireStore(doc));
      }
      return result;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<StockAdmin> getProductStock(String id) async {
    try {
      DocumentSnapshot stock =
          await _firebaseFirestore.collection('stock_admin').doc(id).get();
      if (stock.exists) {
        return StockModelAdmin.fromFireStore(stock);
      } else {
        throw const FirebaseExceptions(
            message: "We couldn't get this object.", statusCode: 404);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<StockAdmin> getProductStockByProductId(String id) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection('stock_admin')
          .where('product_id', isEqualTo: id)
          .get();
      return StockModelAdmin.fromFireStore(querySnapshot.docs.first);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> removeProductStock(String id) async {
    try {
      await _firebaseFirestore.collection('stock_admin').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> updateProduct(String stockId, String userId, bool isNewUser,
      {bool isAble = true}) async {
    try {
      DocumentSnapshot myStock =
          await _firebaseFirestore.collection('stock_admin').doc(stockId).get();
      var myData = myStock.data() as Map;
      List<String> myUser = myData['users_id'] as List<String>;
      if (isNewUser) {
        if (userId.isNotEmpty) {
          if (!myUser.contains(userId)) {
            myUser.add(userId);
            await _firebaseFirestore
                .collection('stock_admin')
                .doc(stockId)
                .update({
              'users_id': myUser,
            });
          }
        }
      } else if (!isNewUser && userId.isNotEmpty) {
        myUser.remove(userId);
        await _firebaseFirestore.collection('stock_admin').doc(stockId).update({
          'users_id': myUser,
        });
      }
      await _firebaseFirestore.collection('stock_admin').doc(stockId).update({
        'is_able': isAble,
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
