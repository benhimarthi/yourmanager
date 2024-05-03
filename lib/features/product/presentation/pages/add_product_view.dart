import 'package:flutter/material.dart';

import 'add_product_small_screen.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      if (constraint.maxWidth <= 768) {
        return const AddProductSmallScreen();
      } else {
        return Container(
          color: Colors.amber,
        );
      }
    });
  }
}
