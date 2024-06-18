import 'package:flutter/material.dart';

ListView listViewWidget(List<Widget> myItems, int limit, {bool all = false}) {
  return ListView(
    children: all ? myItems : List.generate(limit, (index) => myItems[index]),
  );
}
