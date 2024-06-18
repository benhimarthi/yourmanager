import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

class StockModel extends Stock {
  const StockModel({
    required super.id,
    required super.productId,
    required super.currentQuantity,
    required super.quantity,
    required super.minQuantity,
    required super.userId,
    required super.stockCostPrice,
    required super.costPrice,
    required super.discount,
    required super.configured,
    required super.expenditures,
  });

  factory StockModel.empty() {
    return const StockModel(
      id: "",
      productId: "",
      currentQuantity: -1,
      quantity: -1,
      minQuantity: -1,
      userId: '',
      stockCostPrice: 0.0,
      costPrice: 0.0,
      discount: 0.0,
      configured: false,
      expenditures: [],
    );
  }

  factory StockModel.fromFireStore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return StockModel(
      id: doc.id,
      productId: data['product_id'] ?? '',
      currentQuantity: data['current_quantity'] ?? 0,
      quantity: data['quantity'] ?? 0,
      minQuantity: data['min_quantity'] ?? 0,
      userId: data['user_id'] ?? '',
      stockCostPrice: double.parse(data['stock_cost_price'].toString()),
      costPrice: double.parse(data['cost_price'].toString()),
      discount: double.parse(data['discount'].toString()),
      configured: data['configured'] ?? false,
      expenditures: data['expenditures'],
    );
  }
}
