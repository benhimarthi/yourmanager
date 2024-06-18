import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yourmanager/core/widgets/screen_separator.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/admin/stock_admin_cubit.dart';
import 'package:yourmanager/features/stock/presentation/pages/admin_pages/product_profile_components/product_users_indicator.dart';

import '../../../../../img_vids/presentation/cubit/representation_cubit.dart';
import '../../../../../img_vids/presentation/cubit/representation_state.dart';
import '../../../../../product/domain/entities/product.dart';
import '../../../Cubit/admin/stock_admin_state.dart';

class ProductProfileAdminSmallScreen extends StatefulWidget {
  Product product;
  ProductProfileAdminSmallScreen({super.key, required this.product});

  @override
  State<ProductProfileAdminSmallScreen> createState() =>
      _ProductProfileAdminSmallScreenState();
}

class _ProductProfileAdminSmallScreenState
    extends State<ProductProfileAdminSmallScreen> {
  late File? _imageFile;
  late String imageName;
  late String stockId;
  late bool activated;
  late bool stockAble;
  late List productUsers;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        if (_imageFile!.path.isNotEmpty) {
          context.read<RepresentationCubit>().uploadImage(_imageFile!);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _imageFile = File.fromUri(Uri());
    activated = false;
    stockAble = false;
    stockId = "";
    productUsers = [];
    context
        .read<StockAdminCubit>()
        .getProductStockByProductId(widget.product.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 67, 175, 237),
          elevation: 0,
          title: const Text("Product details"),
          actions: [
            MaterialButton(
              onPressed: () {
                setState(() {
                  if (activated == true && stockAble) {
                    context
                        .read<StockAdminCubit>()
                        .updateProduct(stockId, '', false, isAble: false);
                  } else if (activated == false && stockAble) {
                    context
                        .read<StockAdminCubit>()
                        .updateProduct(stockId, '', false, isAble: true);
                  } else if (stockAble == false) {
                    context
                        .read<StockAdminCubit>()
                        .createNewProductStock(widget.product.id);
                  }
                });
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: activated ? Colors.green : Colors.grey,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Activate",
                  style: TextStyle(
                    color: activated ? Colors.green : Colors.grey,
                  ),
                ),
              ),
            )
          ],
        ),
        body: BlocConsumer<StockAdminCubit, StockAdminState>(
          listener: (context, state) {
            if (state is GetProductStockFailed) {}
            if (state is GetProductStockByProductIdSuccessfully) {
              setState(() {
                activated = state.myProduct.isAble;
                stockAble = true;
                stockId = state.myProduct.id;
                productUsers = state.myProduct.usersId;
                print(state.myProduct.usersId);
              });
            }
            if (state is ProductStockCreatedSuccessfully) {
              setState(() {
                activated = true;
                stockAble = true;
                context
                    .read<StockAdminCubit>()
                    .getProductStockByProductId(widget.product.id);
              });
            }
            if (state is UpdateProductSuccessfully) {
              context
                  .read<StockAdminCubit>()
                  .getProductStockByProductId(widget.product.id);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 217, 217),
                              borderRadius: BorderRadius.circular(75),
                              image: DecorationImage(
                                image: NetworkImage(widget.product
                                    .image), //_imageFile == null ?  : FileImage(_imageFile!),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: widget.product.image.isEmpty
                                  ? const Icon(
                                      Icons.inventory,
                                      color: Colors.white,
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 125,
                          child: BlocConsumer<RepresentationCubit,
                              RepresentationState>(
                            listener: (context2, state) {
                              if (state is ImageUploadSuccessfully) {
                                imageName = state.imageFile;
                              }
                            },
                            builder: (context2, state) {
                              return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      getImage();
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 20,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    productProperty(
                      Icons.qr_code_2,
                      widget.product.barcode,
                      () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    productProperty(
                      Icons.category,
                      widget.product.category,
                      () {},
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    screenSeparator(),
                    const SizedBox(
                      height: 20,
                    ),
                    ProductUserIndicator(
                      productUsers: productUsers,
                    ),
                    screenSeparator(),
                  ],
                ),
              ),
            );
          },
        ));
  }

  Widget productProperty(IconData preffixIcon, String value, onTapEdit) {
    return Container(
      padding: const EdgeInsets.all(4),
      width: MediaQuery.of(context).size.width * .85,
      height: 45,
      decoration: BoxDecoration(
          color: const Color.fromARGB(183, 255, 255, 255),
          borderRadius: BorderRadius.circular(50)),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              preffixIcon,
              color: Colors.white,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.white,
          child: Center(
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
          ),
        )
      ]),
    );
  }
}
