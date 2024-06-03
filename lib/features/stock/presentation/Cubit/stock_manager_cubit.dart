import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/stock/domaine/usecases/add_item_in_inventory.dart';
import 'package:yourmanager/features/stock/domaine/usecases/get_all_stocks.dart';
import 'package:yourmanager/features/stock/domaine/usecases/get_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/remove_item_from_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/remove_stock.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_state.dart';

class StockManagerCubit extends Cubit<StockManagerState> {
  final AddItemInInventory _addItemInInventory;
  final GetAllStock _getAllStock;
  final GetStock _getStock;
  final RemoveItemFromStock _removeItemFromStock;
  final RemoveStock _removeStock;

  StockManagerCubit(
      {required AddItemInInventory addItemInInventory,
      required GetAllStock getAllStock,
      required GetStock getStock,
      required RemoveItemFromStock removeItemFromStock,
      required RemoveStock removeStock})
      : _addItemInInventory = addItemInInventory,
        _getAllStock = getAllStock,
        _getStock = getStock,
        _removeItemFromStock = removeItemFromStock,
        _removeStock = removeStock,
        super(const InitiateStockManager());

  Future<void> addItemInInventory(
      String stockId, String productId, int quantity, String userId) async {
    final result = await _addItemInInventory(
      AddItemInStockParam(
        quantity: quantity,
        productId: productId,
        stockId: stockId,
        userId: userId,
      ),
    );
    result.fold(
        (failure) => emit(const ItemAddInSTockFailed(
            "A problem occured while adding item to the inventory, please try again!.")),
        (_) => emit(const ItemAddInStockSuccessfully()));
  }

  Future<void> getAllStock() async {
    final result = await _getAllStock();
    result.fold(
        (failure) => emit(const GetAllStockFailed(
            "A problem occured while trying to retrive stocks, please try again.")),
        (products) => emit(GetAllStockSuccessfully(products)));
  }

  Future<void> getStock(String stockId) async {
    final result = await _getStock(stockId);
    result.fold(
        (failure) => emit(const GetStockFailed(
            "A problem occured while trying to retrive stock, please try again.")),
        (product) => emit(GetStockSuccessfully(product)));
  }

  Future<void> removeItemFromStock(String stockId, int quantity) async {
    final result = await _removeItemFromStock(
        RemoveItemFromInventoryParam(quantity: quantity, stockId: stockId));
    result.fold(
        (failure) => emit(const RemoveItemFromStockFailed(
            "We couldn't remove the item from your stock, please try one more time.")),
        (_) => emit(const RemoveItemFromStockSuccessfully()));
  }

  Future<void> removeStock(String stockId) async {
    final result = await _removeStock(stockId);
    result.fold(
        (failure) => emit(const RemoveStockFailed(
            "We couldn't remove the stock, please try one more time.")),
        (_) => emit(const RemoveStockSuccessfully()));
  }
}
