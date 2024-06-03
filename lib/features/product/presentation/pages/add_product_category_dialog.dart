import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../categories/presentation/cubit/product_category_cubit.dart';

class AddProductCategoryDialog extends StatelessWidget {
  const AddProductCategoryDialog({super.key, required this.nameController});

  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(labelText: "Product category name"),
              ),
              ElevatedButton(
                  onPressed: () {
                    final name = nameController.text.trim();
                    context
                        .read<ProductCategoryCubit>()
                        .addProductCategory(name, DateTime.now());
                    context
                        .read<ProductCategoryCubit>()
                        .getAllProductCategories();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Create new product category"))
            ],
          ),
        ),
      ),
    );
  }
}
