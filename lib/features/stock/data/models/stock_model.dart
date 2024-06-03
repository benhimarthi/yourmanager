import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

class StockModel extends Stock {
  const StockModel({
    required super.id,
    required super.productId,
    required super.quantity,
    required super.userId,
  });

  factory StockModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StockModel(
      id: doc.id,
      productId: data['product_id'] ?? '',
      quantity: data['quantity'] ?? 0,
      userId: data['user_id'] ?? '',
    );
  }
}
