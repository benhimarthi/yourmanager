import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';

import '../../../../../core/util/typedef.dart';
import '../../repositories/stock_repository_admin.dart';

class GetProductStockByProductId extends UseCaseWithParam<StockAdmin, String> {
  final StockRepositoryAdmin _repositoryAdmin;

  GetProductStockByProductId(this._repositoryAdmin);

  @override
  ResultFuture<StockAdmin> call(String params) {
    return _repositoryAdmin.getProductStockByProductId(params);
  }
}
