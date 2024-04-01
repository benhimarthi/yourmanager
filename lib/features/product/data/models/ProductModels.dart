import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.title,
    required super.description,
    required super.category,
    required super.price,
    required super.stockPrice,
    required super.images,
  });

  factory ProductModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return ProductModel(
        id: doc.id,
        title: data['title'] ?? '',
        description: data['description'] ?? '',
        category: data['category'] ?? '',
        price: (data['price'] ?? 0.0).toDouble(),
        stockPrice: (data['stock_price'] ?? 0.0).toDouble(),
        images: data['images'] ?? []);
  }
}
