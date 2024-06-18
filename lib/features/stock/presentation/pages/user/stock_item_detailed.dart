import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_cubit_manager.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/stock_item_detailed_content.dart';
import '../../../../product/presentation/Cubit/product_manager_state.dart';
import '../../../domaine/entities/stock.dart';

class StockItemDetailed extends StatefulWidget {
  final Stock stockItem;
  final List<Stock> allMyStocks;
  const StockItemDetailed(
      {super.key, required this.stockItem, required this.allMyStocks});

  @override
  State<StockItemDetailed> createState() => _StockItemDetailedState();
}

class _StockItemDetailedState extends State<StockItemDetailed> {
  final dataMap = <String, double>{
    "Sales numbers": 12,
  };
  late Product myProduct;

  @override
  void initState() {
    super.initState();
    myProduct = Product(
      expirationDate: DateTime.now().toString(),
      barcode: '6111673425907',
      discount: 8.0,
      id: 'hjgjd',
      title: 'ketchup ketchup ketchup',
      description: "pour les frites",
      category: 'food',
      price: 18.0,
      stockPrice: 0,
      image: '',
    );
    context.read<ProductManagerCubit>().getAllProducts();
    context.read<ExpenditureCubit>().getAllExpenditures();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {
        if (state is GetAllProductsSuccessfully) {
          for (var n in state.myProducts) {
            if (n.id == widget.stockItem.productId) {
              myProduct = n;
            }
          }
        }
      },
      builder: (context, state) {
        return state is GetAllProductsSuccessfully
            ? stockItemDetailedContent(
                context,
                dataMap,
                widget.stockItem,
                widget.allMyStocks,
                myProduct,
              )
            : stockItemDetailedContent(
                context,
                dataMap,
                widget.stockItem,
                widget.allMyStocks,
                null,
                retriveDataFailed: true,
              );
      },
    );
  }
}
