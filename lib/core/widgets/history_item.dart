import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/features/img_vids/presentation/widgets/custom_circle_avatar.dart';
import 'package:yourmanager/features/product/data/models/product_models.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import '../../features/product/domain/entities/product.dart';
import '../../features/product/presentation/Cubit/product_manager_state.dart';
import '../../features/sale/domaine/entities/sale.dart';
import '../../features/stock/domaine/entities/stock.dart';

Widget historyItem(Sale saleItem, Stock myStock) {
  //Sale sale, Product prod
  return BlocConsumer<ProductManagerCubit, ProductManagerState>(
    listener: (context, state) {
      // TODO: implement listener
    },
    builder: (context, state) {
      if (state is GetAllProductsSuccessfully) {
        var prods = state.myProducts
            .where(
              (element) => element.id == saleItem.productId,
            )
            .toList();
        Product myProd = prods.isNotEmpty ? prods.first : ProductModel.empty();
        return ListTile(
          title: Text(
            myProd.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            'total amount : ${saleItem.quantity * myStock.costPrice} dh',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w300,
            ),
          ),
          leading: Stack(
            alignment: Alignment.center,
            children: [
              const SizedBox(
                width: 70,
                height: 70,
              ),
              CCircleAvatar(
                icon: Icons.inventory,
                imagePath: myProd.image,
              ),
              Positioned(
                left: 35,
                bottom: 0,
                child: Container(
                  //width: 28,
                  height: 20,
                  padding: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(75, 0, 0, 0),
                          offset: Offset(0.5, 2.5),
                          blurRadius: 3)
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'x${saleItem.quantity}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ),
                ),
              )
            ],
          ),
          trailing: SizedBox(
              width: 150,
              height: 30,
              //color: Colors.white,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '${saleItem.date.hour}h : ${saleItem.date.minute}m',
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        );
      } else {
        return const SizedBox();
      }
    },
  );
}
