import 'package:flutter/material.dart';

screenSeparator() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 5,
      ),
      Container(
        width: 10,
        height: 2,
        color: Colors.white,
      ),
      Row(
        children: List.generate(
            24,
            (index) => Container(
                  margin: const EdgeInsets.only(
                    right: 2,
                    left: 2,
                  ),
                  width: 10,
                  height: 2,
                  color: Colors.white,
                )),
      ),
      Container(
        width: 10,
        height: 2,
        color: Colors.white,
      ),
      const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 5,
      ),
    ],
  );
}
