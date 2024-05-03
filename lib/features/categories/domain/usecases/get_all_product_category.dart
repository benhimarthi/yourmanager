import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/entities/category.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

class GetAllProductCategory extends UseCaseWithoutParam<List<Category>> {
  final ProductCategoryRepository _repository;
  GetAllProductCategory(this._repository);

  @override
  ResultFuture<List<Category>> call() {
    return _repository.getAllProductCategories();
  }
}
