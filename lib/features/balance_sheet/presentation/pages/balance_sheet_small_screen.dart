import 'package:flutter/material.dart';

import '../../../../core/util/change_screen_mang.dart';
import '../../../../core/widgets/history_item.dart';
import '../../../../core/widgets/list_view_widgets.dart';
import '../../../sale/presentation/pages/history_view_small_screen.dart';

class BalanceSheetSmallScreen extends StatefulWidget {
  final DateTime date;
  const BalanceSheetSmallScreen({
    super.key,
    required this.date,
  });
  @override
  State<BalanceSheetSmallScreen> createState() =>
      _BalanceSheetSmallScreenState();
}

class _BalanceSheetSmallScreenState extends State<BalanceSheetSmallScreen> {
  final Color amountRatioColorGoodIndic = Colors.green;
  final Color amountRatioColorBadIndi = Colors.red;
  final Icon trendUp = const Icon(
    Icons.trending_up,
    size: 24,
    color: Colors.white,
  );
  final Icon trendDown = const Icon(
    Icons.trending_down,
    size: 24,
    color: Colors.white,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: Container(
        width: 60,
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Balance sheet'),
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .5,
            height: 40,
            //color: Colors.amber,
            child: Row(children: [
              Text(
                '${widget.date.month}.${widget.date.day}.${widget.date.year}',
              )
            ]),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          width: double.infinity,
          child: Column(
            children: [
              balanceSheetSection(
                title: 'Amount',
                amount: 1500,
                percentage: 0.2,
              ),
              const SizedBox(height: 20),
              balanceSheetSection(
                  title: "Benefit",
                  amount: 220,
                  percentage: 0.1,
                  isGoodAllure: false),
              const SizedBox(height: 20),
              balanceSheetSection(
                  title: "Expenditures",
                  amount: 43,
                  percentage: .3,
                  showTrending: false),
              const SizedBox(height: 20),
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
              SizedBox(
                width: double.infinity,
                height: 210,
                //color: Colors.amber,
                child: ListViewWidget([
                  historyItem(widget.date),
                  historyItem(widget.date),
                  //historyItem(date),
                ], 4),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget balanceSheetSection({
    required String title,
    double amount = 0.0,
    double percentage = 0.0,
    bool isGoodAllure = true,
    bool showTrending = true,
  }) {
    return Column(children: [
      SizedBox(
        width: double.infinity,
        child: Text(
          title,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * .6,
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$amount DH',
                  style: const TextStyle(fontSize: 32, color: Colors.white),
                ),
                Text(
                  '$percentage %',
                  style: TextStyle(
                      fontSize: 20,
                      color: showTrending
                          ? (isGoodAllure
                              ? amountRatioColorGoodIndic
                              : amountRatioColorBadIndi)
                          : Colors.white),
                )
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .25,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Visibility(
                  visible: showTrending,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: isGoodAllure
                          ? amountRatioColorGoodIndic
                          : amountRatioColorBadIndi,
                    ),
                    child: Center(
                      child: IconButton(
                        onPressed: () {},
                        icon: isGoodAllure ? trendUp : trendDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ]);
  }
}
