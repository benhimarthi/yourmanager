import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/sale/presentation/cubit/sale_manager_cubit.dart';
import '../../features/sale/presentation/cubit/sale_manager_state.dart';
import '../../features/stock/presentation/Cubit/stock_manager_cubit.dart';
import '../../features/stock/presentation/Cubit/stock_manager_state.dart';
import '../util/current_user_informations.dart';
import 'history_item.dart';
import 'list_view_widgets.dart';

historicDisplayer({
  bool all = false,
  required DateTime date,
}) {
  return BlocConsumer<SaleManagerCubit, SaleManagerState>(
    listener: (context, state) {
      if (state is GetAllSalesSuccessfully) {
        print(state.mySales);
      }
    },
    builder: (context, state) {
      return state is GetAllSalesSuccessfully
          ? state.mySales
                  .where(
                    (element) =>
                        element.date.day == date.day &&
                        element.date.month == date.month &&
                        element.date.year == date.year,
                  )
                  .isNotEmpty
              ? SizedBox(
                  width: double.infinity,
                  height: 230,
                  child: BlocConsumer<StockManagerCubit, StockManagerState>(
                    listener: (context1, state1) {},
                    builder: (context1, state1) {
                      if (state1 is GetAllStockSuccessfully) {
                        state.mySales.sort(
                          (a, b) {
                            if (a.quantity > b.quantity) {
                              return a.quantity;
                            } else {
                              return b.quantity;
                            }
                          },
                        );
                        return listViewWidget(
                            state.mySales
                                .where(
                              (element) =>
                                  element.date.day == date.day &&
                                  element.date.month == date.month &&
                                  element.date.year == date.year,
                            )
                                .map((e) {
                              var currentStock = state1.myStocks.where((x) {
                                return x.productId == e.productId;
                              }).toList();
                              return historyItem(e, currentStock.first);
                            }).toList(),
                            4,
                            all: all);
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                )
              : SizedBox(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      "No sale today",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
          : SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: IconButton(
                    onPressed: () {
                      context.read<SaleManagerCubit>().getAllSale(userUID);
                    },
                    icon: const Icon(Icons.replay)),
              ),
            );
    },
  );
}
