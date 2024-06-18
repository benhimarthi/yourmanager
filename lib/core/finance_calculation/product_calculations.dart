//goods sells total amount
import '../../features/expenditure/domain/entities/expenditure.dart';
import '../../features/stock/domaine/entities/stock.dart';

double stockTotalCostAmount(
  double stockPrice,
  double expenditures,
) {
  return stockPrice + expenditures;
}

double totalRevenu(
  double unitPrice,
  double sellQuantity,
) {
  return unitPrice * sellQuantity;
}

double benefit(
  double totalRevenu,
  double stockTotalCost,
) {
  return totalRevenu - stockTotalCost;
}

double stockTotalAmount(List myStocks) {
  double sum = 0;
  for (var n in myStocks) {
    sum += n.stockCostPrice;
  }
  return sum;
}

double expenditureTotalAmount(List myExpenses) {
  double sum = 0;
  for (var n in myExpenses) {
    sum += n.amount;
  }
  return sum;
}

double percentage(double value, double maxValue) {
  return (value / maxValue) * 100;
}
