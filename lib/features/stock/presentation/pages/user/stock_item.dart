import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_cubit.dart';
import 'package:yourmanager/features/img_vids/presentation/cubit/representation_state.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import '../../../../product/domain/entities/product.dart';
import '../../../domaine/entities/stock.dart';

class StockItem extends StatefulWidget {
  final String displayMode;
  final Stock stock;
  final List<String>? myProductIds;
  const StockItem({
    super.key,
    required this.stock,
    this.myProductIds,
    this.displayMode = 'inLine',
  });

  @override
  State<StockItem> createState() => _StockItemState();
}

class _StockItemState extends State<StockItem> {
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
    context.read<ProductManagerCubit>().getProduct(widget.stock.productId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {
        if (state is GetProductByIdSuccessfully) {
          context.read<RepresentationCubit>().getImage(state.myProduct.image);
        }
      },
      builder: (context, state) {
        return state is GetProductByIdSuccessfully
            ? BlocConsumer<RepresentationCubit, RepresentationState>(
                builder: (context, state0) {
                  return widget.displayMode == 'grid'
                      ? Container(
                          height: 150,
                          width: 120,
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(imgLink),
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
                                    color: const Color.fromARGB(
                                        197, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(1),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.myProduct.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        state.myProduct.category,
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        state.myProduct.barcode,
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
                                child: stockIndicator(
                                    widget.stock.currentQuantity,
                                    widget.stock.minQuantity),
                              )
                            ],
                          ),
                        )
                      : ListTile(
                          title: Text(
                            state.myProduct.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            'category: ${state.myProduct.category} | barcode: ${state.myProduct.barcode}',
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          leading: CCircleAvatar(
                            icon: Icons.inventory,
                            imagePath: state.myProduct.image,
                          ),
                          trailing: stockIndicator(widget.stock.currentQuantity,
                              widget.stock.minQuantity),
                        );
                },
                listener: (context, state0) {
                  if (state0 is GetImageSuccessfully) {
                    setState(() {
                      imgLink = state0.imageLink;
                    });
                  }
                },
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

  stockIndicator(int nb, int minQuantity) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'x${nb.toString()}',
        style: TextStyle(
          color: nb <= minQuantity ? Colors.red : Colors.green,
        ),
      ),
    );
  }
}
