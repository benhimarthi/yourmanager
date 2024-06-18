import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/sale/domaine/usecases/delete_sale.dart';
import 'package:yourmanager/features/sale/domaine/usecases/get_all_sales.dart';
import 'package:yourmanager/features/sale/domaine/usecases/get_sale.dart';
import 'package:yourmanager/features/sale/domaine/usecases/register_sale.dart';
import 'package:yourmanager/features/sale/presentation/cubit/sale_manager_state.dart';

class SaleManagerCubit extends Cubit<SaleManagerState> {
  final DeleteSale _deleteSale;
  final GetAllSale _getAllSale;
  final GetSale _getSale;
  final RegisterSale _registerSale;

  SaleManagerCubit(
      {required DeleteSale deleteSale,
      required GetAllSale getAllSale,
      required GetSale getSale,
      required RegisterSale registerSale})
      : _deleteSale = deleteSale,
        _getAllSale = getAllSale,
        _getSale = getSale,
        _registerSale = registerSale,
        super(const InitializedSaleService());

  Future<void> registerSale(
    String userId,
    String productId,
    int quantity,
    DateTime date,
  ) async {
    emit(const IsRegisteringSale());
    final result = await _registerSale(RegisterSaleParams(
      userId: userId,
      productId: productId,
      quantity: quantity,
      date: date,
    ));
    result.fold(
        (failure) => emit(const SaleRegistrationFailed(
            "Something went wrong while registrating your sale, please try again.")),
        (_) => emit(const SaleRegisteredSuccessfully()));
  }

  Future<void> getSale(String saleId) async {
    emit(const IsGettingSale());
    final result = await _getSale(GetSaleParams(saleId, ''));
    result.fold(
        (failure) => emit(const GetSaleFailed(
            "Something went wrong while trying to get the Sale item.")),
        (sale) => emit(GetSaleSuccessfully(sale)));
  }

  Future<void> getAllSale(String userID) async {
    emit(const IsGettingAllSales());
    final result = await _getAllSale(userID);
    result.fold(
        (failure) => emit(const GetSaleFailed(
            "Something went wrong while trying to get the Sales.")),
        (sale) => emit(GetAllSalesSuccessfully(sale)));
  }

  Future<void> deleteSale(String id) async {
    emit(const IsDeletingSale());
    final result = await _deleteSale(DeleteSaleParam(id, ''));
    result.fold(
        (failure) => emit(const SaleDeletionFailed(
            "we couldn't remove this item, please try again.")),
        (_) => emit(const SaleDeletedSuccessfully()));
  }
}
