import 'package:flutter/material.dart';
import 'package:yourmanager/core/util/app_colors.dart';

class SmallText extends StatelessWidget {
  final String content;
  final Color color;
  final double fontSize;
  const SmallText(
      {super.key,
      required this.content,
      this.color = textColor1,
      this.fontSize = 12});

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
