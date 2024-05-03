import 'package:flutter/material.dart';

import 'balance_sheet_small_screen.dart';

class BalanceSheetPage extends StatefulWidget {
  const BalanceSheetPage({super.key});

  @override
  State<BalanceSheetPage> createState() => _BalanceSheetPageState();
}

class _BalanceSheetPageState extends State<BalanceSheetPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 768) {
        return BalanceSheetSmallScreen(
          date: DateTime(2024, 4, 30),
        );
      } else {
        return Container();
      }
    });
  }
}
