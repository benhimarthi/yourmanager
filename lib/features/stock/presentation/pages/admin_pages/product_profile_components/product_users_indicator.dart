import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yourmanager/features/authentication/presentation/cubit/admin/user_admin_manager_cubit.dart';

import '../../../../../authentication/domain/entities/users.dart';
import '../../../../../authentication/presentation/cubit/admin/user_admin_manager_state.dart';

class ProductUserIndicator extends StatefulWidget {
  final List productUsers;
  const ProductUserIndicator({super.key, required this.productUsers});

  @override
  State<ProductUserIndicator> createState() => _ProductUserIndicatorState();
}

class _ProductUserIndicatorState extends State<ProductUserIndicator> {
  final dataMap = <String, double>{
    "Quantity of users": 0,
  };
  late double userQuantity;
  late List<Users> myUsers;
  late double userPercentage;
  @override
  void initState() {
    super.initState();
    context.read<UserAdminManagerCubit>().getAllUsers();
    myUsers = [];
    userQuantity = 100;
    userPercentage = 0;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserAdminManagerCubit, UserAdminManagerState>(
      listener: (context, state) {
        if (state is GetAllUsersSuccessfully) {
          setState(() {
            myUsers = state.myUsers;
            dataMap['Quantity of users'] =
                double.parse(widget.productUsers.length.toString());
            userQuantity = double.parse(myUsers.length.toString());
            userPercentage =
                ((dataMap['Quantity of users']! / userQuantity) * 100);
          });
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const Text(
                    'User percentage',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 148,
                    height: 32,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: const Center(
                      child: Text('See the users'),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 200,
              child: Align(
                alignment: Alignment.centerLeft,
                child: PieChart(
                  chartRadius: 120,
                  dataMap: dataMap,
                  colorList: const [Colors.white],
                  chartValuesOptions: const ChartValuesOptions(
                      showChartValues: false,
                      showChartValueBackground: false,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: true,
                      chartValueStyle: TextStyle(color: Colors.white)),
                  centerWidget: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(131, 0, 0, 0),
                          offset: Offset(.1, 3),
                          blurRadius: 5,
                        )
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '$userPercentage %',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  totalValue: userQuantity,
                ),
              ),
            ),
            Text(
              "${dataMap['Quantity of users']!.toString()} of $userQuantity  users use this product.",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        );
      },
    );
  }
}
