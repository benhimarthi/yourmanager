import 'package:flutter/material.dart';
import 'package:yourmanager/features/stock/presentation/pages/stock_main_view_small_screen.dart';

class StockMainView extends StatefulWidget {
  const StockMainView({super.key});

  @override
  State<StockMainView> createState() => _StockMainViewState();
}

class _StockMainViewState extends State<StockMainView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const StockMainViewSmallScreen();
      } else {
        return Container();
      }
    }));
  }
}
