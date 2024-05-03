import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

class AddProductCategory
    extends UseCaseWithParam<void, AddProductCategoryParam> {
  final ProductCategoryRepository _repository;
  const AddProductCategory(this._repository);
  @override
  ResultFuture<void> call(AddProductCategoryParam params) {
    return _repository.addProductCategory(params.categoryName, params.date);
  }
}

class AddProductCategoryParam {
  final String categoryName;
  final DateTime date;
  AddProductCategoryParam({
    required this.categoryName,
    required this.date,
  });
}
