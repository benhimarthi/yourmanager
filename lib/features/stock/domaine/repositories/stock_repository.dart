import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

abstract class StockRepository {
  ResultVoid addItemsInStock(
    int itemNumber,
    String productId,
    String stockId,
    String userId,
  );
  ResultVoid removeItemFromStock(int quantity, String stockId);
  ResultFuture<List<Stock>> getAllStock();
  ResultFuture<Stock> getStock(String id);
  ResultFuture<Stock> getStockByUserId(String id);
  ResultVoid removeStock(String id);
}
