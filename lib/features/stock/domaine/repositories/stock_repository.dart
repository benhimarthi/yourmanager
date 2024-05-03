import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

abstract class StockRepository {
  ResultVoid addItemsInStock(int itemNumber, String productId, String stockId);
  ResultVoid removeItemFromStock(int quantity, String stockId);
  ResultFuture<List<Stock>> getAllStock();
  ResultFuture<Stock> getStock(String id);
  ResultVoid removeStock(String id);
}
