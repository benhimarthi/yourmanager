import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/categories/datas/models/product_category.dart';

abstract class ProductCategoryRemoteDataSource {
  Future<void> addProductCategory(String categoryName, DateTime date);
  Future<ProductCategory> getProductCategory(String id);
  Future<List<ProductCategory>> getAllProductCategories();
  Future<void> updateProductCategory(
      String id, String categoryName, DateTime date);
  Future<void> deleteProductCategory(String id);
}

class ProductCategoryRemoteDataSourceImpl
    extends ProductCategoryRemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  ProductCategoryRemoteDataSourceImpl(this._firebaseFirestore);
  @override
  Future<void> addProductCategory(String categoryName, DateTime date) async {
    try {
      await _firebaseFirestore
          .collection('product_category')
          .add({'category_name': categoryName, 'date': date.toString()});
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<void> deleteProductCategory(String id) async {
    try {
      await _firebaseFirestore.collection('product_category').doc(id).delete();
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<List<ProductCategory>> getAllProductCategories() async {
    List<ProductCategory> productsCategories = [];
    try {
      QuerySnapshot myCategories =
          await _firebaseFirestore.collection('product_category').get();
      for (var n in myCategories.docs) {
        productsCategories.add(ProductCategory.fromFirestore(n));
      }
      return productsCategories;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<ProductCategory> getProductCategory(String id) async {
    try {
      DocumentSnapshot myCategory = await _firebaseFirestore.doc(id).get();
      return ProductCategory.fromFirestore(myCategory);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }

  @override
  Future<void> updateProductCategory(
      String id, String categoryName, DateTime date) async {
    try {
      await _firebaseFirestore.doc(id).update({
        'category_name': categoryName,
        'date': date.toString(),
      });
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(
          message: e.message.toString(), statusCode: int.parse(e.code));
    }
  }
}
