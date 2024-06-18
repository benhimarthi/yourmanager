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

class IsAddingItemInStock extends StockManagerState {
  const IsAddingItemInStock();
}

class ItemAddInStockSuccessfully extends StockManagerState {
  final String stockId;
  const ItemAddInStockSuccessfully(this.stockId);
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

class IsGettingStock extends StockManagerState {
  const IsGettingStock();
}

class GetStockSuccessfully extends StockManagerState {
  final Stock stock;
  const GetStockSuccessfully(this.stock);
}

class GetStockFailed extends StockManagerState {
  final String message;
  const GetStockFailed(this.message);
}

class IsUpdatingStock extends StockManagerState {
  const IsUpdatingStock();
}

class UpdateStockSuccessfully extends StockManagerState {
  const UpdateStockSuccessfully();
}

class UpdateStockFailed extends StockManagerState {
  final String message;
  const UpdateStockFailed(this.message);
}

class IsManagingExpenditures extends StockManagerState {
  const IsManagingExpenditures();
}

class ManageExpenditureSuccessfully extends StockManagerState {
  const ManageExpenditureSuccessfully();
}

class ManageExpenditureFailed extends StockManagerState {
  final String message;
  const ManageExpenditureFailed(this.message);
}

class IsSettingUpConfiguedValue extends StockManagerState {
  const IsSettingUpConfiguedValue();
}

class SettingConfiguredValueSuccessfully extends StockManagerState {
  const SettingConfiguredValueSuccessfully();
}

class SettinConfiguredValueFailed extends StockManagerState {
  final String message;
  const SettinConfiguredValueFailed(this.message);
}

class RemoveStockSuccessfully extends StockManagerState {
  const RemoveStockSuccessfully();
}

class RemoveStockFailed extends StockManagerState {
  final String message;
  const RemoveStockFailed(this.message);
}
