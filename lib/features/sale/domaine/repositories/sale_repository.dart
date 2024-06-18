import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';

abstract class SaleRepository {
  ResultVoid registerSale(
    String userId,
    String productId,
    int quantity,
    DateTime date,
  );
  ResultVoid deleteSale(String userId, String id);
  ResultFuture<Sale> getSale(String userId, String saleId);
  ResultFuture<List<Sale>> getAllSales(String userId);
}
