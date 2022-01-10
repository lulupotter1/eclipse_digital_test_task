import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';

class CustomRow extends StatelessWidget {
  String left;
  String right;
  TextStyle? rightTextStyle;
  TextStyle? leftTextStyle;
  CustomRow({
    Key? key,
    required this.left,
    required this.right,
    this.leftTextStyle,
    this.rightTextStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$left - ',
          style: leftTextStyle ?? ThemeTextStyle.R18black,
        ),
        Expanded(
          child: Text(
            '"$right"',
            style: rightTextStyle ?? ThemeTextStyle.R18black,
          ),
        ),
      ],
    );
  }
}
