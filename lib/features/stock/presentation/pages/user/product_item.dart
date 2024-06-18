import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import 'package:yourmanager/features/product/presentation/pages/product_details.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock_admin.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_state.dart';

import '../../../../../core/util/current_user_informations.dart';
import '../../../../product/domain/entities/product.dart';

class ProductItem extends StatefulWidget {
  final String displayMode;
  final StockAdmin stockAdmin;
  final List<String> myProductIds;
  const ProductItem({
    super.key,
    required this.stockAdmin,
    required this.myProductIds,
    this.displayMode = 'inLine',
  });

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late Product myProduct;
  late String imgLink;

  @override
  void initState() {
    super.initState();
    myProduct = Product(
      expirationDate: DateTime.now().toString(),
      barcode: '6111673425907',
      discount: 8.0,
      id: 'hjgjd',
      title: 'ketchup ketchup ketchup',
      description: "pour les frites",
      category: 'food',
      price: 18.0,
      stockPrice: 0,
      image: '',
    );
    imgLink = "";
    context.read<ProductManagerCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {
        if (state is IsGettingProduct) {}
        if (state is GetAllProductsSuccessfully) {
          for (var n in state.myProducts) {
            if (n.id == widget.stockAdmin.productId) {
              myProduct = n;
            }
          }
        }
      },
      builder: (context, state) {
        return state is GetAllProductsSuccessfully
            ? widget.displayMode == 'grid'
                ? Container(
                    height: 150,
                    width: 120,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(myProduct.image),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Stack(
                      children: [
                        /*Align(
                          child: Container(
                            width: double.infinity,
                            height: 150,
                            color: Color.fromARGB(124, 255, 255, 255),
                          ),
                        ),*/
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(197, 255, 255, 255),
                              borderRadius: BorderRadius.circular(1),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myProduct.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  myProduct.category,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  myProduct.barcode,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: addStockBtn(myProduct.id),
                        )
                      ],
                    ),
                  )
                : ListTile(
                    title: Text(
                      myProduct.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'category: ${myProduct.category} | barcode: ${myProduct.barcode}',
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    leading: CCircleAvatar(
                      icon: Icons.inventory,
                      imagePath: myProduct.image,
                    ),
                    trailing: addStockBtn(myProduct.id),
                  )
            : Container(
                height: 150,
                width: 120,
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.replay_outlined),
                  ),
                ),
              );
      },
    );
  }

  addStockBtn(productId) {
    return GestureDetector(
      onTap: () {
        if (!widget.myProductIds.contains(productId) &&
            widget.stockAdmin.isAble) {
          context.read<StockManagerCubit>().addItemInInventory(
                "null",
                productId,
                0,
                userUID,
              );
        }
      },
      child: BlocConsumer<StockManagerCubit, StockManagerState>(
        listener: (context, state) {
          if (state is ItemAddInStockSuccessfully) {
            context
                .read<StockAdminCubit>()
                .updateProduct(widget.stockAdmin.id, userUID, true);
            nextScreen(
              context,
              ProductDetails(
                productStockId: state.stockId,
              ),
            );
          }
        },
        builder: (context, state) {
          return CircleAvatar(
            radius: 15,
            backgroundColor: widget.stockAdmin.isAble
                ? const Color.fromARGB(255, 57, 185, 40)
                : Colors.grey,
            child: const Center(
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
