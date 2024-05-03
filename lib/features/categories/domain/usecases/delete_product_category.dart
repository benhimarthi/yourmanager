import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/categories/domain/repositories/product_category_repository.dart';

class DeleteProductCategory extends UseCaseWithParam<void, String> {
  final ProductCategoryRepository _repository;
  const DeleteProductCategory(this._repository);

  @override
  ResultFuture<void> call(String params) {
    return _repository.deleteProductCategory(params);
  }
}
