import 'package:bloc/bloc.dart';
import 'package:yourmanager/features/product/domain/usecases/get_all_products.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/create_new_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_all_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/get_product_stock_by_product_id.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/remove_product_stock.dart';
import 'package:yourmanager/features/stock/domaine/usecases/admin/update_product_stock.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_state.dart';

class StockAdminCubit extends Cubit<StockAdminState> {
  final CreateNewProductStock _createNewProductStock;
  final GetProductStock _getProductStock;
  final GetProductStockByProductId _getProductStockByProductId;
  final GetAllProductStock _getAllProducts;
  final RemoveProductStock _removeProductStock;
  final UpdateProductStock _updateProductStock;

  StockAdminCubit({
    required CreateNewProductStock createNewProductStock,
    required GetProductStock getProductStock,
    required GetProductStockByProductId getProductStockByProductId,
    required GetAllProductStock getAllProducts,
    required RemoveProductStock removeProductStock,
    required UpdateProductStock updateProductStock,
  })  : _createNewProductStock = createNewProductStock,
        _getProductStock = getProductStock,
        _getProductStockByProductId = getProductStockByProductId,
        _getAllProducts = getAllProducts,
        _removeProductStock = removeProductStock,
        _updateProductStock = updateProductStock,
        super(const StockAdminInitial());

  Future<void> createNewProductStock(String productId) async {
    final result = await _createNewProductStock(productId);
    result.fold(
        (failure) => emit(const ProductStockCreationFailed(
            "A problem accured while trying to create a stock for this product.")),
        (_) => emit(const ProductStockCreatedSuccessfully()));
  }

  Future<void> getProductStock(String id) async {
    final result = await _getProductStock(id);
    result.fold(
        (failure) => emit(const GetProductStockFailed(
            "A problem occured while trying to get product stock!.")),
        (productStock) => emit(GetProductStockSuccessfully(productStock)));
  }

  Future<void> getProductStockByProductId(String id) async {
    final result = await _getProductStockByProductId(id);
    result.fold(
        (failure) => emit(const GetProductStockByProductIdFailed(
            "A problem occured while trying to get the product by product id!.")),
        (myProductStock) =>
            (GetProductStockByProductIdSuccessfully(myProductStock)));
  }

  Future<void> getAllProductStock() async {
    final result = await _getAllProducts();
    result.fold(
        (failure) => emit(const GetAllProductStockFailed(
            "A problem occured while trying to get all the product!.")),
        (myProducts) => emit(GetAllProductStockSuccessfully(myProducts)));
  }

  Future<void> removeProductStock(String id) async {
    final result = await _removeProductStock(id);
    result.fold(
        (failure) => emit(const RemoveProductStockFailed(
            "A problem occured while trying to remove this product stock!.")),
        (_) => emit(const RemoveProductStockSuccessfully()));
  }

  Future<void> updateProduct(
    String stockId,
    String userId,
    bool isNewUser, {
    bool isAble = true,
  }) async {
    final result = await _updateProductStock(UpdateProductParams(
        stockId: stockId,
        userId: userId,
        isNewUser: isNewUser,
        isAble: isAble));
    result.fold(
        (failure) => emit(const UpdateProductFailed(
            "A problem occured while trying to update the product stock!.")),
        (_) => emit(const UpdateProductSuccessfully()));
  }
}
