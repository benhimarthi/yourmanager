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
    String productId,
    int quantity,
    DateTime date,
  ) async {
    final result = await _registerSale(RegisterSaleParams(
        productId: productId, quantity: quantity, date: date));
    result.fold(
        (failure) => emit(const SaleRegistrationFailed(
            "Something went wrong while registrating your sale, please try again.")),
        (_) => emit(const SaleRegisteredSuccessfully()));
  }

  Future<void> getSale(String saleId) async {
    final result = await _getSale(saleId);
    result.fold(
        (failure) => emit(const GetSaleFailed(
            "Something went wrong while trying to get the Sale item.")),
        (sale) => emit(GetSaleSuccessfully(sale)));
  }

  Future<void> getAllSale() async {
    final result = await _getAllSale();
    result.fold(
        (failure) => emit(const GetSaleFailed(
            "Something went wrong while trying to get the Sales.")),
        (sale) => emit(GetAllSalesSuccessfully(sale)));
  }

  Future<void> deleteSale(String id) async {
    final result = await _deleteSale(id);
    result.fold(
        (failure) => emit(const SaleDeletionFailed(
            "we couldn't remove this item, please try again.")),
        (_) => emit(const SaleDeletedSuccessfully()));
  }
}
