import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
import 'package:pie_chart/pie_chart.dart';
//import 'package:fl_chart/fl_chart.dart';

class ProductDetailSmallScreen extends StatefulWidget {
  const ProductDetailSmallScreen({super.key});

  @override
  State<ProductDetailSmallScreen> createState() =>
      _ProductDetailSmallScreenState();
}

class _ProductDetailSmallScreenState extends State<ProductDetailSmallScreen> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];

  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "Flutter": 16,
    };
    final colorList = <Color>[
      Colors.greenAccent,
    ];
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      /*floatingActionButton: GestureDetector(
        child: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(Icons.edit_document),
        ),
      ),*/
      appBar: AppBar(
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 219, 219, 219),
                      radius: 55,
                      child: Center(
                        child: Icon(Icons.inventory),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Product Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.white),
                          ),
                          Text(
                            'Barcode',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            'Expiry date',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ]),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              //color: Color.fromARGB(255, 35, 196, 35),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        infoUnit('Unit price', 45, 'DH'),
                        infoUnit('Stock price', 220, 'DH'),
                        infoUnit('Benefit', 43, ''),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        infoUnit('Quantity', 45, 'PC'),
                        infoUnit('Sale quantity', 12, 'PC'),
                        infoUnit('Sale Benefit', 103, 'DH'),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              width: double.infinity,
              height: 200,
              color: const Color.fromARGB(121, 255, 255, 255),
              child: Sparkline(
                data: data,
                lineWidth: 2.5,
                lineColor: Colors.white,
                pointsMode: PointsMode.last,
                pointSize: 8.0,
                pointColor: Colors.amber,
                useCubicSmoothing: true,
                cubicSmoothingFactor: 0.2,
                averageLine: true,
                averageLabel: true,
                kLine: const ['max', 'min', 'first', 'last'],
                gridLinelabelPrefix: '\$',
                gridLineLabelPrecision: 3,
                enableGridLines: true,
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: PieChart(
                centerWidget: PieChart(
                  dataMap: dataMap,
                  chartType: ChartType.ring,
                  chartRadius: 80,
                  chartValuesOptions: const ChartValuesOptions(
                    chartValueStyle: TextStyle(color: Colors.white),
                    chartValueBackgroundColor: Colors.transparent,
                  ),
                  totalValue: 20,
                  legendOptions: const LegendOptions(showLegends: false),
                ),
                dataMap: dataMap,
                //chartType: ChartType.ring,
                baseChartColor: Colors.grey[50]!.withOpacity(0.15),
                colorList: colorList,
                chartValuesOptions: const ChartValuesOptions(
                  showChartValueBackground: false,
                  showChartValuesInPercentage: true,
                  showChartValuesOutside: true,
                ),
                totalValue: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoUnit(String title, double amount, String suff) {
    return SizedBox(
      width: 140,
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            height: 36,
            width: 107,
            decoration: BoxDecoration(
              color: const Color.fromARGB(163, 217, 217, 217),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
                child: Text(
              "$amount $suff",
              style: const TextStyle(
                  color: Color.fromARGB(182, 250, 198, 43),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
          )
        ],
      ),
    );
  }
}
