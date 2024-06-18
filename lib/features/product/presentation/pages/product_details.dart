import 'package:flutter/material.dart';
import 'package:yourmanager/features/product/presentation/pages/product_details_small_screen.dart';

class ProductDetails extends StatefulWidget {
  final String productStockId;
  const ProductDetails({super.key, required this.productStockId});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth <= 768) {
        return ProductDetailSmallScreen(
          productStockId: widget.productStockId,
        );
      } else {
        return Container();
      }
    });
  }
}
