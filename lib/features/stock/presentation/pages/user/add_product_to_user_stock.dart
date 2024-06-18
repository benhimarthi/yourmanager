import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/product_item.dart';

import '../../Cubit/admin/stock_admin_state.dart';

class AddProductToUserStockView extends StatefulWidget {
  const AddProductToUserStockView({super.key});

  @override
  State<AddProductToUserStockView> createState() =>
      _AddProductToUserStockViewState();
}

class _AddProductToUserStockViewState extends State<AddProductToUserStockView> {
  List<String> myProductsIds = [];
  late String displayMode = "";
  late List<StockAdmin> myProds;
  @override
  void initState() {
    super.initState();
    displayMode = 'inLine';
    myProductsIds = [];
    myProds = [];
    context.read<StockAdminCubit>().getAllProductStock();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          title: const Text("Add product to stock"),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_sharp),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.barcode_reader),
            )
          ],
        ),
        body: BlocConsumer<StockAdminCubit, StockAdminState>(
          listener: (context, state) {
            if (state is GetAllProductStockSuccessfully) {
              myProds = state.myProducts;
            }
          },
          builder: (context, state) {
            return state is GetAllProductStockSuccessfully
                ? state.myProducts.isNotEmpty
                    ? displayMode == 'grid'
                        ? GridView.count(
                            crossAxisCount: 2,
                            children: [
                              ProductItem(
                                stockAdmin: state.myProducts.last,
                                myProductIds: [],
                                displayMode: 'grid',
                              ),
                              ProductItem(
                                stockAdmin: state.myProducts.first,
                                myProductIds: [],
                                displayMode: 'grid',
                              )
                            ],
                          )
                        : Column(
                            children: List.of(
                              state.myProducts.map((e) {
                                return ProductItem(
                                  stockAdmin: e,
                                  myProductIds: myProductsIds,
                                  displayMode: displayMode,
                                );
                              }),
                            ),
                          )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: const Center(
                          child: Text("No product"),
                        ),
                      )
                : SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: IconButton(
                        onPressed: () {
                          context.read<StockAdminCubit>().getAllProductStock();
                        },
                        icon: const Icon(
                          Icons.replay,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
          },
        ));
  }
}
