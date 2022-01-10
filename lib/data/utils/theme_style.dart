import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';
import 'package:flutter/material.dart';

class ThemeTextStyle {
  static const R18black = TextStyle(
      color: ThemeColors.black, fontSize: 18, fontWeight: FontWeight.w500);
  static const R18blackItalic = TextStyle(
      color: ThemeColors.black,
      fontSize: 18,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.italic);
  static const R18white = TextStyle(
      color: ThemeColors.white, fontSize: 18, fontWeight: FontWeight.w500);
  static const R18Linkblue = TextStyle(
      decorationStyle: TextDecorationStyle.solid,
      decorationColor: ThemeColors.blue,
      decorationThickness: 2,
      color: ThemeColors.blue,
      fontSize: 18,
      fontWeight: FontWeight.w500);
}
