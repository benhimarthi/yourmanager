import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';

class SaleModel extends Sale {
  const SaleModel({
    required super.id,
    required super.productId,
    required super.quantity,
    required super.date,
    required super.userId,
  });

  factory SaleModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SaleModel(
      id: doc.id,
      userId: data['user_id'] ?? '',
      productId: data['product_id'] ?? '',
      quantity: data['quantity'] ?? 0,
      date: DateTime.parse(data['date'] ?? ""),
    );
  }
}
