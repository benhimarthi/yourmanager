import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/app_colors.dart';

class BigText extends StatelessWidget {
  final String content;
  final Color color;
  final double fontSize;
  const BigText(
      {super.key,
      required this.content,
      this.color = textColor1,
      this.fontSize = 20});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      ),
    );
  }
}
