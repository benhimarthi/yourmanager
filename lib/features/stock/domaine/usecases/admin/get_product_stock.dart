import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../repositories/stock_repository_admin.dart';

class GetProductStock extends UseCaseWithParam<StockAdmin, String> {
  final StockRepositoryAdmin _repositoryAdmin;

  GetProductStock(this._repositoryAdmin);

  @override
  ResultFuture<StockAdmin> call(String params) {
    return _repositoryAdmin.getProductStock(params);
  }
}
