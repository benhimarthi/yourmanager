import 'package:flutter/material.dart';
import 'package:yourmanager/features/sale/presentation/pages/sales_main_screen_small_screen.dart';

import 'home_page_small_screen.dart';

class SaleMainPage extends StatefulWidget {
  const SaleMainPage({super.key});

  @override
  State<SaleMainPage> createState() => _SaleMainPageState();
}

class _SaleMainPageState extends State<SaleMainPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 768) {
        return const SaleMainPageSmallScreen();
      } else {
        return Container();
      }
    });
  }
}
