import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository_admin.dart';

class UpdateProductStock extends UseCaseWithParam<void, UpdateProductParams> {
  final StockRepositoryAdmin _repositoryAdmin;

  UpdateProductStock(this._repositoryAdmin);

  @override
  ResultFuture<void> call(UpdateProductParams params) {
    return _repositoryAdmin.updateProduct(
      params.stockId,
      params.userId,
      params.isNewUser,
      params.isAble,
    );
  }
}

class UpdateProductParams {
  final String stockId;
  final String userId;
  final bool isNewUser;
  final bool isAble;

  UpdateProductParams({
    required this.stockId,
    required this.userId,
    required this.isNewUser,
    required this.isAble,
  });
}
