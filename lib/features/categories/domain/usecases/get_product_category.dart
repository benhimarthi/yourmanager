import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/entities/category.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

class GetProductCategory extends UseCaseWithParam<Category, String> {
  final ProductCategoryRepository _repository;
  GetProductCategory(this._repository);

  @override
  ResultFuture<Category> call(String params) {
    return _repository.getProductCategory(params);
  }
}
