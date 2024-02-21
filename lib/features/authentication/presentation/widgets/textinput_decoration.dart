import 'package:flutter/material.dart';

import '../../../../core/util/app_colors.dart';

const textInputDecoration = InputDecoration(
  filled: true,
  fillColor: textFieldBackgroundcolor,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: onUnFocusTextFieldBorderColor,
      width: 3,
    ),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: onErrorTextFieldBorderColor,
      width: 3,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: onFocusTextFieldBorderColor,
      width: 3,
    ),
  ),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white, width: 3),
  ),
);
