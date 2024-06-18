import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_state.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/stock_item_detailed.dart';

class UserStockMainViewSmallView extends StatefulWidget {
  const UserStockMainViewSmallView({super.key});

  @override
  State<UserStockMainViewSmallView> createState() =>
      _UserStockMainViewSmallViewState();
}

class _UserStockMainViewSmallViewState
    extends State<UserStockMainViewSmallView> {
  @override
  void initState() {
    super.initState();
    context.read<StockManagerCubit>().getAllStock();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StockManagerCubit, StockManagerState>(
      listener: (context, state) {
        if (state is GetAllStockFailed) {}
        if (state is GetAllStockSuccessfully) {}
      },
      builder: (context, state) {
        return state is GetAllStockSuccessfully
            ? state.myStocks.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: const Center(
                        child: Text(
                      "You have no stock for now.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        state.myStocks.length,
                        (index) => StockItemDetailed(
                          stockItem: state.myStocks[index],
                          allMyStocks: state.myStocks,
                        ),
                      ),
                    ),
                  )
            : Center(
                child: IconButton(
                  onPressed: () {
                    context.read<StockManagerCubit>().getAllStock();
                  },
                  icon: const Icon(Icons.replay),
                ),
              );
      },
    );
  }
}
