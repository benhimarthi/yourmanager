import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';

class ProductManagerState extends Equatable {
  const ProductManagerState();
  @override
  List<Object?> get props => [];
}

class ProductManagerStateInitial extends ProductManagerState {
  const ProductManagerStateInitial();
}

class IsGettingProduct extends ProductManagerState {
  const IsGettingProduct();
}

class GetProductByIdSuccessfully extends ProductManagerState {
  final Product myProduct;
  const GetProductByIdSuccessfully(this.myProduct);
}

class GetProductByIdFailed extends ProductManagerState {
  final String message;
  const GetProductByIdFailed(this.message);
}

class IsGettingProductByBarcode extends ProductManagerState {
  const IsGettingProductByBarcode();
}

class GetProductByBarcodeSuccessfully extends ProductManagerState {
  final Product myProduct;
  const GetProductByBarcodeSuccessfully(this.myProduct);
}

class GetProductByBarcodeFailed extends ProductManagerState {
  final String message;
  const GetProductByBarcodeFailed(this.message);
}

class GettingAllproduct extends ProductManagerState {
  const GettingAllproduct();
}

class GetAllProductsSuccessfully extends ProductManagerState {
  final List<Product> myProducts;
  const GetAllProductsSuccessfully(this.myProducts);
}

class GetAllProductsFailed extends ProductManagerState {
  final String message;
  const GetAllProductsFailed(this.message);
}

class AddAProductSuccessfully extends ProductManagerState {
  final Product newProduct;
  const AddAProductSuccessfully(this.newProduct);
}

class AddAProductFailed extends ProductManagerState {
  final String message;
  const AddAProductFailed(this.message);
}

class UpdateProductInfosSuccessfully extends ProductManagerState {
  final Product productUpdated;
  const UpdateProductInfosSuccessfully(this.productUpdated);
}

class UpdateProductInfosFailed extends ProductManagerState {
  final String message;
  const UpdateProductInfosFailed(this.message);
}

class DeleteProductSuccessfully extends ProductManagerState {
  const DeleteProductSuccessfully();
}

class DeleteProductFailed extends ProductManagerState {
  final String message;
  const DeleteProductFailed(this.message);
}

class EndProcess extends ProductManagerState {
  final dynamic value;
  const EndProcess(this.value);
}
