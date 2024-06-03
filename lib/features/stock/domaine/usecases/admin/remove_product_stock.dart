import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository_admin.dart';

class RemoveProductStock extends UseCaseWithParam<void, String> {
  final StockRepositoryAdmin _repositoryAdmin;

  RemoveProductStock(this._repositoryAdmin);

  @override
  ResultFuture<void> call(String params) {
    return _repositoryAdmin.removeProductStock(params);
  }
}
