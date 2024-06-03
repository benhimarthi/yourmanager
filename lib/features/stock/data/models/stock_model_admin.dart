import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';

class StockModelAdmin extends StockAdmin {
  const StockModelAdmin({
    required super.id,
    required super.productId,
    required super.usersId,
    required super.isAble,
  });

  factory StockModelAdmin.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StockModelAdmin(
      id: doc.id,
      productId: data['product_id'] ?? '',
      usersId: data['user_id'] ?? '',
      isAble: data['is_able'] ?? true,
    );
  }
}
