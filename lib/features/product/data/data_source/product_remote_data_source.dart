import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yourmanager/core/errors/exceptions.dart';
import 'package:yourmanager/features/product/data/models/ProductModels.dart';
import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSrc {
  Future<Product> addNewProduct(
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  );
  Future<Product> getProduct(String id);
  Future<List<Product>> getAllProducts();
  Future<Product> updateProductInformations(
    String id,
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  );
  Future<void> removeProduct(String id);
}

class ProductRemoteDataScrImpl implements ProductRemoteDataSrc {
  final FirebaseFirestore _firebaseFirestore;
  ProductRemoteDataScrImpl(this._firebaseFirestore);
  @override
  Future<Product> addNewProduct(
    String title,
    String description,
    String category,
    double price,
    double stockPrice,
    List<String> images,
  ) async {
    try {
      DocumentReference productRef =
          await _firebaseFirestore.collection('products').add({
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'stock_price': stockPrice,
        'images': images
      });
      DocumentSnapshot docSnapshot = await productRef.get();
      if (docSnapshot.exists) {
        return ProductModel.fromFirestore(docSnapshot);
      } else {
        throw const FirebaseExceptions(
            message: "A problem occure during the creation of the product.",
            statusCode: 404);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<List<Product>> getAllProducts() async {
    List<Product> products = [];
    try {
      QuerySnapshot querySnapshot =
          await _firebaseFirestore.collection('products').get();
      for (var doc in querySnapshot.docs) {
        products.add(ProductModel.fromFirestore(doc));
      }
      return products;
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<Product> getProduct(String id) async {
    try {
      DocumentSnapshot docSnapshot =
          await _firebaseFirestore.collection('products').doc(id).get();

      if (docSnapshot.exists) {
        return ProductModel.fromFirestore(docSnapshot);
      } else {
        throw const FirebaseExceptions(
            message: "The product you are looking for doesn't exist.",
            statusCode: 500);
      }
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }

  @override
  Future<void> removeProduct(String id) async {
    try {
      await _firebaseFirestore.collection('products').doc(id).delete();
    } on FirebaseException catch (e) {
      throw const FirebaseExceptions(
          message: "an Error occur during the deletion of the product.",
          statusCode: 404);
    }
  }

  @override
  Future<Product> updateProductInformations(
      String id,
      String title,
      String description,
      String category,
      double price,
      double stockPrice,
      List<String> images) async {
    try {
      await _firebaseFirestore.collection('products').doc(id).update({
        'title': title,
        'description': description,
        'category': category,
        'price': price,
        'stock_price': stockPrice,
        'images': images,
      });
      return getProduct(id);
    } on FirebaseException catch (e) {
      throw FirebaseExceptions(message: e.toString(), statusCode: 404);
    }
  }
}
