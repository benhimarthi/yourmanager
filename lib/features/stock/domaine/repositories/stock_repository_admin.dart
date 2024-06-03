import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';

abstract class StockRepositoryAdmin {
  ResultVoid createNewProductStock(String productId);
  ResultFuture<StockAdmin> getProductStock(String id);
  ResultFuture<StockAdmin> getProductStockByProductId(String id);
  ResultFuture<List<StockAdmin>> getAllProductStock();
  ResultVoid removeProductStock(String id);
  ResultVoid updateProduct(
    String stockId,
    String userId,
    bool isNewUser,
    bool isAble,
  );
}
