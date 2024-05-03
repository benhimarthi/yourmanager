import 'package:flutter/material.dart';

ListTile historyItem(date) {
  //Sale sale, Product prod
  return ListTile(
    title: const Text(
      "Product name",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subtitle: const Text(
      'unit price: 45 dh',
      style: TextStyle(
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
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 207, 207, 207),
            borderRadius: BorderRadius.circular(27),
          ),
          child: const Center(
            child: Icon(
              Icons.inventory_2,
              size: 24,
            ),
          ),
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
            child: const Center(
              child: Text(
                '16x',
                style: TextStyle(color: Colors.green),
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
            '${date.hour}h : ${date.minute}m : ${date.second}s',
            style: const TextStyle(color: Colors.white),
          ),
        )),
  );
}
