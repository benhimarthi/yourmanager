import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/entities/category.dart';

abstract class ProductCategoryRepository {
  ResultVoid addProductCategory(String categoryName, DateTime date);
  ResultFuture<Category> getProductCategory(String id);
  ResultFuture<List<Category>> getAllProductCategories();
  ResultVoid updateProductCategory(
      String id, String categoryName, DateTime date);
  ResultVoid deleteProductCategory(String id);
}
