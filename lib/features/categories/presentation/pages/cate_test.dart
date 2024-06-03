import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/categories/presentation/cubit/category_state.dart';

import '../cubit/product_category_cubit.dart';

class CategoryT extends StatefulWidget {
  const CategoryT({super.key});

  @override
  State<CategoryT> createState() => _CategoryTState();
}

class _CategoryTState extends State<CategoryT> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController namecontroller = TextEditingController();
    return BlocConsumer<ProductCategoryCubit, CategoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Material(
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
                      controller: namecontroller,
                      decoration: const InputDecoration(
                          labelText: "Product category name"),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          final name = namecontroller.text.trim();
                          context
                              .read<ProductCategoryCubit>()
                              .addProductCategory(name, DateTime.now());
                          //Navigator.of(context).pop();
                        },
                        child: const Text("Create new product category"))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
