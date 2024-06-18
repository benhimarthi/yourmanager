import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/user_stock_main_view_small_screen.dart';

class UserStockMainView extends StatefulWidget {
  const UserStockMainView({super.key});

  @override
  State<UserStockMainView> createState() => _UserStockMainViewState();
}

class _UserStockMainViewState extends State<UserStockMainView> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return const UserStockMainViewSmallView();
      } else {
        return Container();
      }
    });
  }
}
