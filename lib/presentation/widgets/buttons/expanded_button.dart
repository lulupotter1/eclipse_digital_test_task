import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  void Function()? onPressed;

  CustomButton({required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(ThemeColors.gray.withOpacity(0.1)),
          foregroundColor: MaterialStateProperty.all(ThemeColors.black)),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
