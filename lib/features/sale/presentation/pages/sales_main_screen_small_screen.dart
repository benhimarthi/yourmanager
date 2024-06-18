import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/current_user_informations.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_state.dart';
import 'package:yourmanager/features/sale/presentation/cubit/sale_manager_cubit.dart';
import '../../../../core/util/change_screen_mang.dart';
import '../../../../core/widgets/custom_calendar.dart';
import '../../../../core/widgets/list_view_widgets.dart';
import '../cubit/sale_manager_state.dart';
import 'history_view_small_screen.dart';

class SaleMainPageSmallScreen extends StatefulWidget {
  const SaleMainPageSmallScreen({super.key});

  @override
  State<SaleMainPageSmallScreen> createState() =>
      _SaleMainPageSmallScreenState();
}

class _SaleMainPageSmallScreenState extends State<SaleMainPageSmallScreen> {
  final date = DateTime.now();
  late int month;
  late int year;
  final int maxMonth = 12;
  final int minMonth = 1;
  @override
  void initState() {
    super.initState();
    month = 3; //date.month;
    year = date.year;
    context.read<SaleManagerCubit>().getAllSale(userUID);
    context.read<ProductManagerCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    //print(DateUtils.firstDayOffset(2024, 3, MaterialLocalizations.of(context)));
    return BlocConsumer<ProductManagerCubit, ProductManagerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
          child: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            "DH 478.54",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 220, 65),
                                fontSize: 24),
                          ),
                          Text(
                            "0.52 %",
                            style: TextStyle(
                                //fontWeight: FontWeight.w300,
                                color: Colors.white,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.all(10),
                  child: const CustomCalandar()),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best sales',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            nextScreen(context, const HistoryViewSmallScreen());
                          });
                        },
                        icon: const Icon(
                          Icons.history,
                          color: Colors.white,
                        ))
                  ],
                ),
              ),
              BlocConsumer<SaleManagerCubit, SaleManagerState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return state is GetAllSalesSuccessfully
                      ? SizedBox(
                          width: double.infinity,
                          height: 210,
                          //color: Colors.amber,
                          /*child: ListViewWidget([
                            //historyItem(date),
                            //historyItem(date),
                            //historyItem(date),
                          ], 4),*/
                        )
                      : SizedBox(
                          height: 300,
                          child: Center(
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.replay),
                            ),
                          ),
                        );
                },
              )
            ],
          )),
        );
      },
    );
  }
}
