import 'package:yourmanager/features/product/domain/usecases/add_new_product.dart';
import 'package:yourmanager/features/product/domain/usecases/get_product.dart';
import 'package:yourmanager/features/product/domain/usecases/get_product_by_barcode.dart';
import 'package:yourmanager/features/product/domain/usecases/remove_product.dart';
import 'package:yourmanager/features/product/domain/usecases/update_product_informations.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import 'package:bloc/bloc.dart';

import '../../domain/usecases/get_all_products.dart';

class ProductManagerCubit extends Cubit<ProductManagerState> {
  final AddNewProduct _addNewProduct;
  final GetAllProducts _getAllProducts;
  final RemoveProduct _removeProduct;
  final UpdateProductInformations _updateProductInfos;
  final GetProduct _getProduct;
  final GetProductByBarcode _getProductByBarcode;

  ProductManagerCubit({
    required AddNewProduct addAProduct,
    required GetAllProducts getAllProducts,
    required RemoveProduct removeProduct,
    required UpdateProductInformations updateProductInformations,
    required GetProduct getProduct,
    required GetProductByBarcode getProductByBarcode,
  })  : _addNewProduct = addAProduct,
        _getAllProducts = getAllProducts,
        _removeProduct = removeProduct,
        _updateProductInfos = updateProductInformations,
        _getProduct = getProduct,
        _getProductByBarcode = getProductByBarcode,
        super(const ProductManagerStateInitial());

  Future<void> addProduct(
    String title,
    String description,
    String category,
    String expirationDate,
    String barcode,
    String image,
    double price,
    double stockPrice,
    double discount,
  ) async {
    final result = await _addNewProduct(
      CreateProductParams(
        title: title,
        description: description,
        category: category,
        expirationDate: expirationDate,
        barcode: barcode,
        images: image,
        price: price,
        stockPrice: stockPrice,
        discount: discount,
      ),
    );
    result.fold(
        (failure) =>
            emit(const AddAProductFailed("Sorry we couldn't add this product")),
        (product) => emit(AddAProductSuccessfully(product)));
  }

  Future<void> getAllProducts() async {
    emit(const GettingAllproduct());
    final result = await _getAllProducts();

    result.fold(
        (failure) => emit(const GetAllProductsFailed(
            "A problem occured while trying to get products.")),
        (products) => emit(GetAllProductsSuccessfully(products)));
  }

  Future<void> removeProduct(String id) async {
    final result = await _removeProduct(id);
    result.fold(
        (failure) => emit(const DeleteProductFailed(
            "We couldn't remove this product, please try again.")),
        (_) => emit(const DeleteProductSuccessfully()));
  }

  Future<void> getProduct(String id) async {
    emit(const IsGettingProduct());
    final result = await _getProduct(id);
    result.fold((failure) => emit(GetProductByIdFailed(failure.message)),
        (product) {
      print("WWWWWWWWWWWWWW" + product.title);
      emit(GetProductByIdSuccessfully(product));
    });
  }

  Future<void> getProductByBarcode(String barcode) async {
    emit(const IsGettingProductByBarcode());
    final result = await _getProductByBarcode(barcode);
    result.fold((failure) => emit(GetProductByBarcodeFailed(failure.message)),
        (product) => emit(GetProductByBarcodeSuccessfully(product)));
  }

  Future<void> updateProductInformations(
    String id,
    String title,
    String description,
    String category,
    String image,
    double price,
    double stockPrice,
    double discount,
  ) async {
    final result = await _updateProductInfos(
      UpdateProductInfosParams(
        id: id,
        title: title,
        description: description,
        category: category,
        images: image,
        price: price,
        stockPrice: stockPrice,
        discount: discount,
      ),
    );
    result.fold(
        (failure) => emit(const UpdateProductInfosFailed(
            "Sorry! we couldn't update the informations of this product.")),
        (product) => emit(UpdateProductInfosSuccessfully(product)));
  }

  Future<void> endProcess(dynamic val) async {
    emit(EndProcess(val));
  }
}
