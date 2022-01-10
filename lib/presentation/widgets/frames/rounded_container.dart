import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';

class RoundedContainer extends StatelessWidget {
  EdgeInsetsGeometry? paddings;
  EdgeInsetsGeometry? margin;
  Color? bgColor;
  Widget child;
  RoundedContainer({
    Key? key,
    required this.child,
    this.paddings,
    this.margin,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          margin ?? const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding:
          paddings ?? const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: child,
      decoration: BoxDecoration(
          color: bgColor ?? ThemeColors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 1),
              blurRadius: 1,
              color: ThemeColors.black.withOpacity(0.25),
            ),
          ]),
    );
  }
}
