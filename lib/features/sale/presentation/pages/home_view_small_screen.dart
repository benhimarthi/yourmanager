import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/core/util/current_user_informations.dart';
import 'package:yourmanager/features/product/presentation/Cubit/product_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/cubit/sale_manager_cubit.dart';
import 'package:yourmanager/features/sale/presentation/pages/history_view_small_screen.dart';
import 'package:yourmanager/features/stock/presentation/Cubit/stock_manager_cubit.dart';
import '../../../../core/widgets/historic_displayer.dart';

class HomeViewSmallScreen extends StatefulWidget {
  const HomeViewSmallScreen({super.key});

  @override
  State<HomeViewSmallScreen> createState() => _HomeViewSmallScreenState();
}

class _HomeViewSmallScreenState extends State<HomeViewSmallScreen> {
  final date = DateTime.now();
  final double amount = 250.6;
  final double pourcentage = 0.5;
  @override
  void initState() {
    super.initState();
    context.read<SaleManagerCubit>().getAllSale(userUID);
    context.read<StockManagerCubit>().getAllStock();
    context.read<ProductManagerCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 60),
        SizedBox(
          width: double.maxFinite,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  //width: 270,
                  height: 270,
                ),
                Container(
                  width: 262,
                  height: 262,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(131),
                    color: const Color.fromARGB(255, 217, 217, 217),
                  ),
                ),
                Positioned(
                  right: 300,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125),
                      color: const Color.fromARGB(255, 217, 217, 217),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 300,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125),
                      color: const Color.fromARGB(255, 217, 217, 217),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 240,
                  height: 240,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125),
                      color: const Color.fromARGB(255, 255, 255, 255),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(75, 0, 0, 0),
                            offset: Offset(0.5, 2.5),
                            blurRadius: 3)
                      ],
                      border: Border.all(
                          color: const Color.fromARGB(255, 32, 198, 49),
                          width: 3)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${date.month}.${date.day}.${date.year}",
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text.rich(
                        TextSpan(
                          text: "$amount MAD ",
                          children: <TextSpan>[
                            TextSpan(
                                text: '$pourcentage %',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {})
                          ],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 32, 198, 49),
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 240,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(125),
                      color: const Color.fromARGB(255, 32, 198, 49),
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(75, 0, 0, 0),
                            offset: Offset(0.5, 2.5),
                            blurRadius: 3)
                      ],
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.trending_up_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 40,
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
                      nextScreen(
                          context,
                          HistoryViewSmallScreen(
                            historic: historicDisplayer(all: true, date: date),
                          ));
                    });
                  },
                  icon: const Icon(
                    Icons.history,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        historicDisplayer(date: date),
      ],
    );
  }
}
