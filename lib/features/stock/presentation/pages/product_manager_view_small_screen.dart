import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/loading.dart';
import '../../../img_vids/presentation/widgets/custom_circle_avatar.dart';
import '../../../product/presentation/Cubit/product_manager_cubit.dart';
import '../../../product/presentation/Cubit/product_manager_state.dart';

Widget productManagerViewSmallScreen() {
  return BlocConsumer<ProductManagerCubit, ProductManagerState>(
    listener: (context, state) {},
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
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * .99,
                      height: MediaQuery.of(context).size.height * .99,
                      child: ListView.builder(
                        itemCount: state.myProducts.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                                state.myProducts[index].title,
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: Text(
                                  "${state.myProducts[index].category} | ${state.myProducts[index].barcode}"),
                              leading: CCircleAvatar(
                                icon: Icons.inventory,
                                imagePath: state.myProducts[index].image,
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.edit),
                              ));
                        },
                      ),
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
