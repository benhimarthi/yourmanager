import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/features/categories/domain/entities/category.dart';

class ProductCategory extends Category {
  const ProductCategory(
      {required super.id, required super.categoryName, required super.date});
  factory ProductCategory.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;

    return ProductCategory(
      id: doc.id,
      categoryName: data['category_name'],
      date: DateTime.parse(data['date'].toString()),
    );
  }
}
