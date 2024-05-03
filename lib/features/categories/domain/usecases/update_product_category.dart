import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

class UpdateProductCategory
    extends UseCaseWithParam<void, UpdateProductCategoryParam> {
  final ProductCategoryRepository _repository;
  UpdateProductCategory(this._repository);

  @override
  ResultFuture<void> call(UpdateProductCategoryParam params) {
    return _repository.updateProductCategory(
        params.id, params.categoryName, params.date);
  }
}

class UpdateProductCategoryParam {
  final String id;
  final String categoryName;
  final DateTime date;
  UpdateProductCategoryParam({
    required this.id,
    required this.categoryName,
    required this.date,
  });
}
