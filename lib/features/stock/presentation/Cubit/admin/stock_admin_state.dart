import 'package:equatable/equatable.dart';

import '../../../domaine/entities/stock_admin.dart';

class StockAdminState extends Equatable {
  const StockAdminState();
  @override
  List<Object?> get props => [];
}

class StockAdminInitial extends StockAdminState {
  const StockAdminInitial();
}

class ProductStockCreatedSuccessfully extends StockAdminState {
  const ProductStockCreatedSuccessfully();
}

class ProductStockCreationFailed extends StockAdminState {
  final String message;
  const ProductStockCreationFailed(this.message);
}

class GetProductStockSuccessfully extends StockAdminState {
  final StockAdmin myProduct;
  const GetProductStockSuccessfully(this.myProduct);
}

class GetProductStockFailed extends StockAdminState {
  final String message;
  const GetProductStockFailed(this.message);
}

class IsGettingProductByProductId extends StockAdminState {
  const IsGettingProductByProductId();
}

class GetProductStockByProductIdSuccessfully extends StockAdminState {
  final StockAdmin myProduct;
  const GetProductStockByProductIdSuccessfully(this.myProduct);
}

class GetProductStockByProductIdFailed extends StockAdminState {
  final String message;
  const GetProductStockByProductIdFailed(this.message);
}

class IsGettingAllProducts extends StockAdminState {
  const IsGettingAllProducts();
}

class GetAllProductStockSuccessfully extends StockAdminState {
  final List<StockAdmin> myProducts;
  const GetAllProductStockSuccessfully(this.myProducts);
}

class GetAllProductStockFailed extends StockAdminState {
  final String message;
  const GetAllProductStockFailed(this.message);
}

class RemoveProductStockSuccessfully extends StockAdminState {
  const RemoveProductStockSuccessfully();
}

class RemoveProductStockFailed extends StockAdminState {
  final String message;
  const RemoveProductStockFailed(this.message);
}

class IsUpdatingProduct extends StockAdminState {
  const IsUpdatingProduct();
}

class UpdateProductSuccessfully extends StockAdminState {
  const UpdateProductSuccessfully();
}

class UpdateProductFailed extends StockAdminState {
  final String message;
  const UpdateProductFailed(this.message);
}
