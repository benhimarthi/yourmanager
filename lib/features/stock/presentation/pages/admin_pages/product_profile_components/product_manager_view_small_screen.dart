import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';
import 'package:yourmanager/features/stock/presentation/pages/admin_pages/product_profile_components/product_profile_admin_small_screen.dart';

import '../../../../../../core/widgets/loading.dart';
import '../../../../../img_vids/presentation/widgets/custom_circle_avatar.dart';
import '../../../../../product/domain/entities/product.dart';
import '../../../../../product/presentation/Cubit/product_manager_cubit.dart';
import '../../../../../product/presentation/Cubit/product_manager_state.dart';
import '../../../Cubit/admin/stock_admin_cubit.dart';

class ProductManagerViewSmallScreen extends StatefulWidget {
  const ProductManagerViewSmallScreen({super.key});

  @override
  State<ProductManagerViewSmallScreen> createState() =>
      _ProductManagerViewSmallScreenState();
}

class _ProductManagerViewSmallScreenState
    extends State<ProductManagerViewSmallScreen> {
  late List<Product> myP = [];
  @override
  void initState() {
    super.initState();
    context.read<ProductManagerCubit>().getAllProducts();
    context.read<UserAdminManagerCubit>().getAllUsers();
    myP = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {
        if (state is GetAllProductsSuccessfully) {
          myP = state.myProducts;
        }
      },
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * .99,
          child: state is GettingAllproduct
              ? const SizedBox(
                  height: double.infinity,
                  child: Center(
                    child: LoadingColumn(
                      message: 'Charging products',
                    ),
                  ),
                )
              : state is GetAllProductsSuccessfully
                  ? SingleChildScrollView(
                      child: Column(
                        children: List.generate(myP.length,
                            (index) => inventoryItem(state.myProducts[index])),
                      ),
                    )
                  : Center(
                      child: IconButton(
                        onPressed: () {
                          context.read<ProductManagerCubit>().getAllProducts();
                        },
                        icon: const Icon(Icons.replay),
                      ),
                    ),
        );
      },
    );
  }

  displayer(String name) {
    return Row(
      children: [
        CCircleAvatar(
          icon: Icons.person,
          imagePath: name,
        ),
        Text(name)
      ],
    );
  }

  inventoryItem(Product prod) {
    return GestureDetector(
      onTap: () {
        context.read<StockAdminCubit>().getProductStockByProductId(prod.id);
        nextScreen(
            context,
            ProductProfileAdminSmallScreen(
              product: prod,
            ));
      },
      child: ListTile(
          title: Text(
            prod.title,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          subtitle: Text("${prod.category} | ${prod.barcode}"),
          leading: prod.image.isNotEmpty
              ? CCircleAvatar(
                  icon: Icons.person,
                  imagePath: prod.image,
                )
              : CCircleAvatar(icon: Icons.person),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          )),
    );
  }
}
