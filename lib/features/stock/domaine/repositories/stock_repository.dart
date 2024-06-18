import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

abstract class StockRepository {
  ResultFuture<String> addItemsInStock(
    int itemNumber,
    String productId,
    String stockId,
    String userId,
  );
  ResultVoid updateUserStock(
    String id,
    int quantity,
    int minQuantity,
    double stockCostPrice,
    double costPrice,
    double discount,
  );
  ResultVoid removeItemFromStock(int quantity, String stockId);
  ResultFuture<List<Stock>> getAllStock();
  ResultFuture<Stock> getStock(String id);
  ResultFuture<Stock> getStockByUserId(String id);
  ResultVoid removeStock(String id);
  ResultVoid setConfiguredValue(String id, bool value);
  ResultVoid manageExpenditure(String id, String expenditureId, bool add);
}
