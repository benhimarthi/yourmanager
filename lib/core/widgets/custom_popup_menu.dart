import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  final Map<String, dynamic> menuInfos;
  const CustomPopupMenu({super.key, required this.menuInfos});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        print(value);
      },
      itemBuilder: (BuildContext context) {
        return List.generate(
            menuInfos.length,
            (index) => PopupMenuItem(
                value: menuInfos.values.toList()[index].toString(),
                child: Text(menuInfos.entries.toList()[index].toString())));
      },
    );
  }
}
