import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';

class StockManagerState extends Equatable {
  const StockManagerState();
  @override
  List<Object?> get props => [];
}

class InitiateStockManager extends StockManagerState {
  const InitiateStockManager();
}

class ItemAddInStockSuccessfully extends StockManagerState {
  const ItemAddInStockSuccessfully();
}

class ItemAddInSTockFailed extends StockManagerState {
  final String message;
  const ItemAddInSTockFailed(this.message);
}

class RemoveItemFromStockSuccessfully extends StockManagerState {
  const RemoveItemFromStockSuccessfully();
}

class RemoveItemFromStockFailed extends StockManagerState {
  final String messsage;
  const RemoveItemFromStockFailed(this.messsage);
}

class GetAllStockSuccessfully extends StockManagerState {
  final List<Stock> myStocks;
  const GetAllStockSuccessfully(this.myStocks);
}

class GetAllStockFailed extends StockManagerState {
  final String message;
  const GetAllStockFailed(this.message);
}

class GetStockSuccessfully extends StockManagerState {
  final Stock stock;
  const GetStockSuccessfully(this.stock);
}

class GetStockFailed extends StockManagerState {
  final String message;
  const GetStockFailed(this.message);
}

class RemoveStockSuccessfully extends StockManagerState {
  const RemoveStockSuccessfully();
}

class RemoveStockFailed extends StockManagerState {
  final String message;
  const RemoveStockFailed(this.message);
}
