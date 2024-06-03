import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/product/data/models/product_models.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';

class ProductManagerState extends Equatable {
  const ProductManagerState();
  @override
  List<Object?> get props => [];
}

class ProductManagerStateInitial extends ProductManagerState {
  const ProductManagerStateInitial();
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
