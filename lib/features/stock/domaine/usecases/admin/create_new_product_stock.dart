import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';

import '../../repositories/stock_repository_admin.dart';

class CreateNewProductStock extends UseCaseWithParam<void, String> {
  final StockRepositoryAdmin _repositoryAdmin;

  CreateNewProductStock(this._repositoryAdmin);

  @override
  ResultFuture<void> call(String params) {
    return _repositoryAdmin.createNewProductStock(params);
  }
}
