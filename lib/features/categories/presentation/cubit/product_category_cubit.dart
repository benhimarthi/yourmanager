import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/categories/domain/usecases/add_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/delete_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/get_all_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/get_product_category.dart';
import 'package:yourmanager/features/categories/domain/usecases/update_product_category.dart';

import 'category_state.dart';

class ProductCategoryCubit extends Cubit<CategoryState> {
  final AddProductCategory _addProductCategory;
  final GetProductCategory _getProductCategory;
  final GetAllProductCategory _getAllProductCategory;
  final UpdateProductCategory _updateProductCategory;
  final DeleteProductCategory _deleteProductCategory;
  ProductCategoryCubit({
    required AddProductCategory addProductCategory,
    required GetProductCategory getProductCategory,
    required GetAllProductCategory getAllProductCategory,
    required UpdateProductCategory updateProductCategory,
    required DeleteProductCategory deleteProductCategory,
  })  : _addProductCategory = addProductCategory,
        _getProductCategory = getProductCategory,
        _getAllProductCategory = getAllProductCategory,
        _updateProductCategory = updateProductCategory,
        _deleteProductCategory = deleteProductCategory,
        super(const CategoryInitial());

  Future<void> addProductCategory(String categoryName, DateTime date) async {
    final result = await _addProductCategory(AddProductCategoryParam(
      categoryName: categoryName,
      date: date,
    ));
    result.fold(
        (failure) => emit(const AddCategoryFailed(
            "Sorry we couldn't add this category, please try again.")),
        (_) => const AddCategorySuccessfully());
  }

  Future<void> getProductCategory(String id) async {
    final result = await _getProductCategory(id);
    result.fold(
        (failure) => emit(const GetCategoryFailed(
            "Sorry we couldn't have access to this item.")),
        (myCategory) => emit(GetCategorySuccessfully(myCategory)));
  }

  Future<void> getAllProductCategories() async {
    final result = await _getAllProductCategory();
    result.fold(
        (failure) => emit(const GetAllCategoryFailed(
            "We couldn't get the categories, please try again.")),
        (myCategories) => GetAllCategoriesSuccessfully(myCategories));
  }

  Future<void> updateProductCategory(
    String id,
    String categoryName,
    DateTime date,
  ) async {
    final result = await _updateProductCategory(UpdateProductCategoryParam(
        id: id, categoryName: categoryName, date: date));
    result.fold(
        (failure) => emit(const UpdateCategoryFailed(
            "Sorry!, we couldn't update this category, please try again.")),
        (_) => emit(const UpdateCategorySuccessfully()));
  }

  Future<void> deleteProductCategory(String id) async {
    final result = await _deleteProductCategory(id);
    result.fold(
        (failure) => emit(const DeleteCategoryFailed(
            "Sorry!, we couldn't delete this element, please try again.")),
        (_) => emit(const DeleteCategorySuccessfully()));
  }
}
