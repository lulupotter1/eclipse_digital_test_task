import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';

Future showPageDialog(
  BuildContext context, {
  required String titleText,
  required Widget body,
  bool barrierDismissible = true,
  Color? color = ThemeColors.white,
}) {
  return showDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    builder: (context) {
      return SimpleDialog(
        backgroundColor: color,
        children: [
          body,
        ],
        title: Text(
          titleText,
          style: ThemeTextStyle.R18white,
        ),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.symmetric(horizontal: 25),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: 0,
      );
    },
  );
}
