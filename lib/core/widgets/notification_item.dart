import 'package:flutter/material.dart';

ListTile notificationItem(date) {
  //Sale sale, Product prod
  return ListTile(
    title: const Text(
      "Notification title",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
    subtitle: const Text(
      'Le service sans frais de Google traduit instantanément des mots, des expressions et des pages Web entre le français et plus de 100',
      style: TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
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
          left: 45,
          bottom: 0,
          child: Container(
            width: 20,
            height: 20,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: Color.fromARGB(75, 0, 0, 0),
                    offset: Offset(0.5, 2.5),
                    blurRadius: 3)
              ],
            ),
            /*child: const Center(
              child: Text(
                '16x',
                style: TextStyle(color: Colors.green),
              ),
            ),*/
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
