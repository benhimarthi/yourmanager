import 'package:yourmanager/core/util/typedef.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';

abstract class SaleRepository {
  ResultVoid registerSale(
    String productId,
    int quantity,
    DateTime date,
  );
  ResultVoid deleteSale(String id);
  ResultFuture<Sale> getSale(String saleId);
  ResultFuture<List<Sale>> getAllSales();
}
