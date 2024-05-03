import 'package:equatable/equatable.dart';
import 'package:yourmanager/features/sale/domaine/entities/sale.dart';

class SaleManagerState extends Equatable {
  const SaleManagerState();
  @override
  List<Object?> get props => [];
}

class InitializedSaleService extends SaleManagerState {
  const InitializedSaleService();
}

class SaleRegisteredSuccessfully extends SaleManagerState {
  const SaleRegisteredSuccessfully();
}

class SaleRegistrationFailed extends SaleManagerState {
  final String message;
  const SaleRegistrationFailed(this.message);
}

class SaleDeletedSuccessfully extends SaleManagerState {
  const SaleDeletedSuccessfully();
}

class SaleDeletionFailed extends SaleManagerState {
  final String message;
  const SaleDeletionFailed(this.message);
}

class GetSaleSuccessfully extends SaleManagerState {
  final Sale sale;
  const GetSaleSuccessfully(this.sale);
}

class GetSaleFailed extends SaleManagerState {
  final String message;
  const GetSaleFailed(this.message);
}

class GetAllSalesSuccessfully extends SaleManagerState {
  final List<Sale> mySales;
  const GetAllSalesSuccessfully(this.mySales);
}

class GetAllSalesFailed extends SaleManagerState {
  final String message;
  const GetAllSalesFailed(this.message);
}
