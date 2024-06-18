import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/stock/domaine/usecases/add_item_in_inventory.dart';
import 'package:yourmanager/features/stock/domaine/usecases/get_all_stocks.dart';
import 'package:yourmanager/features/stock/domaine/usecases/get_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/manage_expenditure.dart';
import 'package:yourmanager/features/stock/domaine/usecases/remove_item_from_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/remove_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/set_configured_value.dart';
import 'package:yourmanager/features/stock/domaine/usecases/update_user_stock.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_state.dart';

class StockManagerCubit extends Cubit<StockManagerState> {
  final AddItemInInventory _addItemInInventory;
  final GetAllStock _getAllStock;
  final GetStock _getStock;
  final UpdateUserStock _updateUserStock;
  final RemoveItemFromStock _removeItemFromStock;
  final RemoveStock _removeStock;
  final ManageExpenditure _manageExpenditure;
  final SetConfiguredValue _setConfiguredValue;

  StockManagerCubit({
    required AddItemInInventory addItemInInventory,
    required GetAllStock getAllStock,
    required GetStock getStock,
    required UpdateUserStock updateUserStock,
    required RemoveItemFromStock removeItemFromStock,
    required RemoveStock removeStock,
    required ManageExpenditure manageExpenditure,
    required SetConfiguredValue setConfiguredValue,
  })  : _addItemInInventory = addItemInInventory,
        _getAllStock = getAllStock,
        _getStock = getStock,
        _updateUserStock = updateUserStock,
        _removeItemFromStock = removeItemFromStock,
        _removeStock = removeStock,
        _manageExpenditure = manageExpenditure,
        _setConfiguredValue = setConfiguredValue,
        super(const InitiateStockManager());

  Future<void> addItemInInventory(
    String stockId,
    String productId,
    int quantity,
    String userId,
  ) async {
    emit(const IsAddingItemInStock());
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
      (stcokId) => emit(ItemAddInStockSuccessfully(stockId)),
    );
  }

  Future<void> getAllStock() async {
    final result = await _getAllStock();
    result.fold(
        (failure) => emit(const GetAllStockFailed(
            "A problem occured while trying to retrive stocks, please try again.")),
        (products) => emit(GetAllStockSuccessfully(products)));
  }

  Future<void> getStock(String stockId) async {
    emit(const IsGettingStock());
    final result = await _getStock(stockId);
    result.fold(
      (failure) => emit(const GetStockFailed(
          "A problem occured while trying to retrive stock, please try again.")),
      (product) => emit(
        GetStockSuccessfully(product),
      ),
    );
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

  Future<void> manageExpenditure(
    String productId,
    String expenditureId,
    bool add,
  ) async {
    emit(const IsManagingExpenditures());
    final result = await _manageExpenditure(ManageExpenditureParams(
      productId,
      expenditureId,
      add,
    ));
    result.fold((failure) => emit(ManageExpenditureFailed(failure.message)),
        (_) => emit(const ManageExpenditureSuccessfully()));
  }

  Future<void> updateStock(
    String id,
    int quantity,
    int minQuantity,
    double stockCostPrice,
    double costPrice,
    double discount,
  ) async {
    emit(const IsUpdatingStock());
    final result = await _updateUserStock(UpdateUserStockParams(
      id: id,
      quantity: quantity,
      minQuantity: minQuantity,
      stockCostPrice: stockCostPrice,
      costPrice: costPrice,
      discount: discount,
    ));
    result.fold(
      (failure) => emit(const UpdateStockFailed(
          "A problem occured while trying to update the stock.")),
      (_) => emit(
        const UpdateStockSuccessfully(),
      ),
    );
  }

  Future<void> setConfiguredValue(String id, bool value) async {
    emit(const IsSettingUpConfiguedValue());
    final result =
        await _setConfiguredValue(SetConfiguredValueParams(id, value));
    result.fold(
      (failure) => emit(const SettinConfiguredValueFailed(
          "A problem occured while trying to Set the configured value.")),
      (_) => emit(
        const SettingConfiguredValueSuccessfully(),
      ),
    );
  }
}
