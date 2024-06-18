import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/current_user_informations.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';
import 'package:yourmanager/features/product/data/models/product_models.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/stock/data/models/stock_model.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';

import '../../../../core/util/change_screen_mang.dart';
import '../../../product/presentation/Cubit/product_manager_state.dart';
import '../../../stock/presentation/Cubit/stock_manager_state.dart';
import '../../../stock/presentation/pages/user/configure_stock_view.dart';
import '../cubit/sale_manager_cubit.dart';

class RegisterSell extends StatefulWidget {
  const RegisterSell({super.key});

  @override
  State<RegisterSell> createState() => _RegisterSellState();
}

class _RegisterSellState extends State<RegisterSell> {
  bool multiProduct = true;
  List<SaleItem> productsToRegister = [];
  SaleItem currentSelectedProduct = SaleItem.empty();
  Product currentProd = ProductModel.empty();
  int currentQuantity = 0;
  double totalAmount = 0.0;
  int maxProd = 0;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<StockManagerCubit>().getAllStock();
    context.read<ProductManagerCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 205, 205, 205),
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * .65,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Search product',
                                prefixIcon: Icon(Icons.search),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("TAAAAAAAAAAAAAAAAAAP");
                            },
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(23),
                              ),
                              child: const Icon(
                                Icons.barcode_reader,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .9,
                        height: 35,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            filterOption("Most Popular", false, (v) {}),
                            filterOption("Most expensive", false, (v) {}),
                            filterOption("A-z", false, (v) {}),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: BlocConsumer<StockManagerCubit, StockManagerState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state is GetAllStockSuccessfully
                          ? state.myStocks.isEmpty
                              ? const Center(
                                  child: Text("Your inventory is empty"),
                                )
                              : GridView(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  children: List.of(state.myStocks
                                      .map((e) => productItem(e))),
                                )
                          : Center(
                              child: IconButton(
                                  onPressed: () {
                                    context
                                        .read<StockManagerCubit>()
                                        .getAllStock();
                                    context
                                        .read<ProductManagerCubit>()
                                        .getAllProducts();
                                  },
                                  icon: const Icon(Icons.replay)),
                            );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 100,
                right: 25,
                child: multiProduct
                    ? saleManager(productsToRegister.isNotEmpty &&
                            currentIndex <= productsToRegister.length - 1
                        ? productsToRegister[currentIndex]
                        : SaleItem.empty())
                    : saleManager(currentSelectedProduct),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    margin: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * .8,
                    height: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 212, 212, 212),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(131, 0, 0, 0),
                          offset: Offset(.1, 3),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .7,
                          child: filterOption("Multi product", multiProduct,
                              (val) {
                            setState(() {
                              multiProduct = multiProduct ? false : true;
                            });
                          }),
                        ),
                        GestureDetector(
                          onTap: () {
                            for (var n in productsToRegister) {
                              if (n.quantity >= 1) {
                                context
                                    .read<SaleManagerCubit>()
                                    .registerSale(
                                      userUID,
                                      n.myProduct!.id,
                                      n.quantity,
                                      DateTime.now(),
                                    )
                                    .then((value) {
                                  context
                                      .read<StockManagerCubit>()
                                      .removeItemFromStock(
                                        n.mySTock.id,
                                        n.quantity,
                                      )
                                      .whenComplete(() {
                                    setState(() {
                                      productsToRegister.clear();
                                    });
                                  });
                                });
                              }
                            }
                          },
                          child: Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width * .7,
                            decoration: BoxDecoration(
                              color: productsToRegister.isEmpty
                                  ? Colors.white
                                  : Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Register Sales${productsToRegister.isNotEmpty ? '(${calculateSaleAmount(productsToRegister)} dh)' : ''}",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: productsToRegister.isEmpty
                                      ? Colors.grey
                                      : Colors.white,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  double calculateSaleAmount(List<SaleItem> item) {
    double res = 0;
    for (var n in item) {
      res += n.quantity * n.mySTock.costPrice;
    }
    return res;
  }

  boxInfo(String title, dynamic value) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('$title : '),
          Text(value.toString()),
        ],
      ),
    );
  }

  saleManager(SaleItem? item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * .8,
          padding: const EdgeInsets.all(5),
          height: 150,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(20),
          ),
          child: item!.mySTock != StockModel.empty()
              ? Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        item.myProduct!.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      child: CCircleAvatar(
                        icon: Icons.inventory,
                        imagePath: item.myProduct!.image,
                        radius: 30,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (item.quantity >= 0) {
                                  item.quantity -= 1;
                                }
                              });
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Center(
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            width: 150,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: Text(
                                'x ${item.quantity} | ${item.mySTock.costPrice * item.quantity} dh',
                                style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (item.quantity <
                                    item.mySTock.currentQuantity) {
                                  item.quantity += 1;
                                }
                              });
                            },
                            child: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)),
                              child: const Center(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (currentIndex > 0) {
                                  currentIndex -= 1;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ))),
                    Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (currentIndex <
                                    productsToRegister.length - 1) {
                                  currentIndex += 1;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ))),
                    Align(
                      alignment: Alignment.topLeft,
                      child: boxInfo(
                        "discount",
                        currentSelectedProduct.mySTock.discount,
                      ),
                    ),
                  ],
                )
              : const Center(
                  child: Text(
                    "No element selected",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
        )
      ],
    );
  }

  productItem(Stock item) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is GetAllProductsSuccessfully) {
          var myProduct =
              state.myProducts.where((x) => x.id == item.productId).toList();
          if (myProduct.isNotEmpty) {
            var prod = myProduct.first;
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (item.configured) {
                    //print(productsToRegister.length);
                    if (multiProduct) {
                      bool isPresent = productsToRegister
                          .where((e) => e.mySTock.id == item.id)
                          .toList()
                          .isNotEmpty;
                      if (isPresent) {
                        productsToRegister.removeWhere(
                            (element) => element.mySTock.id == item.id);
                        currentIndex = 0;
                      } else {
                        productsToRegister.add(SaleItem(item, myProduct: prod));
                        currentIndex = productsToRegister.length - 1;
                      }
                      maxProd = productsToRegister.isNotEmpty
                          ? productsToRegister.length - 1
                          : 0;
                    } else {
                      currentSelectedProduct = SaleItem(item);
                      currentProd = prod;
                    }
                  } else {
                    nextScreen(
                      context,
                      ConfigureStockView(
                        stockId: item.id,
                      ),
                    );
                  }
                });
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Visibility(
                    visible: productsToRegister
                        .map((e) => e.mySTock.id)
                        .toList()
                        .contains(item.id),
                    //currentSelectedProduct.mySTock.id == item.id,
                    child: Container(
                      width: 110,
                      height: 110,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(133, 33, 149, 243),
                          borderRadius: BorderRadius.circular(60),
                          border: Border.all(
                            color: const Color.fromARGB(133, 33, 149, 243),
                            width: 3,
                          )),
                    ),
                  ),
                  CCircleAvatar(
                    icon: Icons.inventory,
                    imagePath: prod.image,
                    radius: 45,
                  ),
                  Positioned(
                    right: 0,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 239, 239),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'x ${item.currentQuantity.toString()}',
                        style: TextStyle(
                          color: item.currentQuantity < item.minQuantity
                              ? Colors.red
                              : Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 10,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 239, 239, 239),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        '- ${item.discount.toString()}dh',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: 70,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(183, 239, 239, 239),
                      ),
                      child: Text(
                        prod.title.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(217, 33, 33, 33),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: !item.configured,
                    child: CircleAvatar(
                      radius: 55,
                      backgroundColor: const Color.fromARGB(119, 255, 255, 255),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                nextScreen(
                                    context,
                                    ConfigureStockView(
                                      stockId: item.id,
                                    ));
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.blue,
                              )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        }
        return const CircleAvatar();
      },
    );
  }

  filterOption(String title, bool value, onChanged) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
          ),
        ),
        Checkbox(value: value, onChanged: onChanged),
      ],
    );
  }
}

class SaleItem {
  late int quantity;
  final Stock mySTock;
  late Product? myProduct;
  SaleItem(
    this.mySTock, {
    this.quantity = 1,
    this.myProduct,
  });
  factory SaleItem.empty() {
    return SaleItem(StockModel.empty());
  }
}
