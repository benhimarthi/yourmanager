import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:yourmanager/core/finance_calculation/product_calculations.dart';
import 'package:yourmanager/core/util/change_screen_mang.dart';
import 'package:yourmanager/features/expenditure/domain/entities/expenditure.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_cubit_manager.dart';
import 'package:yourmanager/features/expenditure/presentation/cubit/expenditure_manager_state.dart';
import 'package:yourmanager/features/product/domain/entities/product.dart';
import 'package:yourmanager/features/stock/domaine/entities/stock.dart';
import 'package:yourmanager/features/stock/presentation/pages/user/configure_stock_view.dart';

import '../../../../img_vids/presentation/widgets/custom_circle_avatar.dart';

Widget stockItemDetailedContent(
  context,
  dataMap,
  Stock myStock,
  List<Stock> allStocks,
  Product? product, {
  retriveDataFailed = false,
}) {
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250,
      ),
      Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 10),
        width: MediaQuery.of(context).size.width * .95,
        decoration: BoxDecoration(
          color: const Color.fromARGB(219, 255, 255, 255),
          borderRadius: BorderRadius.circular(20),
        ),
        child: retriveDataFailed
            ? SizedBox(
                height: 250,
                child: Center(
                    child: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.replay))),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 20,
                    width: MediaQuery.of(context).size.width * .94,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          product!.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        infoBox(
                          const Icon(
                            Icons.category,
                            color: Colors.white,
                            size: 10,
                          ),
                          product.category,
                        ),
                        infoBox(
                          const Icon(
                            Icons.qr_code_2,
                            color: Colors.white,
                            size: 10,
                          ),
                          product.barcode,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CCircleAvatar(
                        radius: 50,
                        icon: Icons.inventory,
                        imagePath: product.image,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .55,
                        //height: 80,
                        //color: const Color.fromARGB(136, 244, 67, 54),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Sales numbers',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 97, 97, 97)),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * .28,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Icon(
                                        Icons.filter_list,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                        //color: Colors.grey,
                                        child: const Text(
                                          "Select filter",
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 100,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: PieChart(
                                      chartRadius: 100,
                                      dataMap: dataMap,
                                      colorList: const [
                                        Color.fromARGB(255, 5, 208, 9),
                                      ],
                                      chartValuesOptions:
                                          const ChartValuesOptions(
                                        showChartValues: false,
                                        showChartValueBackground: false,
                                        showChartValuesInPercentage: false,
                                        showChartValuesOutside: true,
                                        chartValueStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 12,
                                        ),
                                      ),
                                      legendOptions: const LegendOptions(
                                          legendTextStyle:
                                              TextStyle(fontSize: 9)),
                                      centerWidget: Container(
                                        width: 50,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 237, 237, 237),
                                          borderRadius:
                                              BorderRadius.circular(35),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            '57 %',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 161, 161, 161),
                                            ),
                                          ),
                                        ),
                                      ),
                                      totalValue: 20,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 50,
                                  bottom: 20,
                                  child: Container(
                                    width: 25,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromARGB(131, 0, 0, 0),
                                          offset: Offset(.1, 3),
                                          blurRadius: 5,
                                        )
                                      ],
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.trending_up,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .95,
                    //height: 85,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        infoNumber(context, 'Stock price',
                            myStock.stockCostPrice.toString(), '5', '%'),
                        infoNumber(context, 'Benefit', '520', '6', '%'),
                        BlocConsumer<ExpenditureCubit, ExpenditureStateManager>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            if (state is GetAllExpenditureSuccessfully) {
                              List myExp = myStock.expenditures
                                  .where((x) => (state.expenditures
                                          .map((e) => e.id)
                                          .toList())
                                      .contains(x))
                                  .toList();

                              double expTot = expenditureTotalAmount(state
                                  .expenditures
                                  .where(
                                      (element) => myExp.contains(element.id))
                                  .toList());
                              double allExpenditures =
                                  expenditureTotalAmount(state.expenditures);
                              double percent =
                                  percentage(expTot, allExpenditures);
                              return infoNumber(
                                context,
                                'Expenditures',
                                expTot.toString(),
                                percent.toString(),
                                '%',
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                        //infoNumber(context, 'Cost price', '250', '12', 'dh'),
                      ],
                    ),
                  )
                ],
              ),
      ),
      Positioned(
        right: 5,
        bottom: 30,
        child: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 216, 216, 216),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Center(
            child: Icon(
              Icons.insert_drive_file_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      ),
      Visibility(
        visible: !myStock.configured,
        child: Container(
          width: MediaQuery.of(context).size.width * .92,
          height: 280,
          decoration: BoxDecoration(
            color: const Color.fromARGB(210, 255, 255, 255),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        "This product stock has not been configured yet, please precede.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromARGB(255, 97, 97, 97)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            nextScreen(
                                context,
                                ConfigureStockView(
                                  stockId: myStock.id,
                                ));
                          },
                          child: const Text("Configure")),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.help,
                      color: Color.fromARGB(255, 97, 97, 97)),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget infoNumber(
  context,
  String name,
  String number,
  String ratio,
  String indicator,
) {
  return Container(
    margin: const EdgeInsets.all(2),
    width: 75,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 76,
          child: Text.rich(
            TextSpan(
              text: number,
              children: const <TextSpan>[
                TextSpan(
                  text: " DH",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w200,
                  ),
                )
              ],
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 70,
          height: 20,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 218, 218, 218),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
              child: Text(
            '$ratio $indicator',
            style: const TextStyle(color: Color.fromARGB(255, 79, 97, 97)),
          )),
        )
      ],
    ),
  );
}

infoBox(Icon ic, String value) {
  return Container(
    height: 20,
    width: 112,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 218, 218, 218),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        const SizedBox(width: 5),
        ic,
        const SizedBox(width: 5),
        SizedBox(
          width: 85,
          child: Text(
            value,
            style: const TextStyle(overflow: TextOverflow.ellipsis),
          ),
        ),
      ],
    ),
  );
}
