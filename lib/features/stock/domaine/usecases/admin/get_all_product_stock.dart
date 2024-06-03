import 'package:yourmanager/core/usecases/usecase.dart';
import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';
import 'package:yourmanager/features/stock/domaine/repositories/stock_repository_admin.dart';

class GetAllProductStock extends UseCaseWithoutParam<List<StockAdmin>> {
  final StockRepositoryAdmin _repositoryAdmin;

  GetAllProductStock(this._repositoryAdmin);

  @override
  ResultFuture<List<StockAdmin>> call() {
    return _repositoryAdmin.getAllProductStock();
  }
}
