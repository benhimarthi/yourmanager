import 'package:flutter/material.dart';
import 'package:yourmanager/core/widgets/list_view_widgets.dart';

class StockMainViewSmallScreen extends StatefulWidget {
  const StockMainViewSmallScreen({super.key});

  @override
  State<StockMainViewSmallScreen> createState() =>
      _StockMainViewSmallScreenState();
}

class _StockMainViewSmallScreenState extends State<StockMainViewSmallScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Theme.of(context).primaryColor,
        width: double.infinity,
        height: MediaQuery.of(context).size.height * .999,
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            productInventoryItem(),
          ],
        ),
      ),
    );
  }

  Widget productInventoryItem(
      {String name = "product_name product name ",
      int quantity = 6,
      int minQuantity = 3}) {
    return Container(
      width: MediaQuery.of(context).size.width * 9,
      //height: 90,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 237, 237, 237),
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Visibility(
                    child: GestureDetector(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 217, 217, 217),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                    child: GestureDetector(
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 217, 217, 217),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        child: GestureDetector(
                          child: Container(
                            width: 54,
                            height: 54,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 217, 217, 217),
                              borderRadius: BorderRadius.circular(27),
                              border: Border.all(width: 3, color: Colors.white),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.inventory,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .3,
                        child: Text(
                          name,
                          style:
                              const TextStyle(overflow: TextOverflow.ellipsis),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: const EdgeInsets.only(top: 5),
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'x$quantity',
                      style: TextStyle(
                          color: quantity <= minQuantity
                              ? Colors.red
                              : Colors.green),
                    ),
                  ),
                ),
              )
            ],
          ),
          Visibility(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              width: MediaQuery.of(context).size.width * 85,
              height: 230,
              color: Colors.amber,
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 85,
                    height: 77,
                    color: const Color.fromARGB(255, 217, 217, 217),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
