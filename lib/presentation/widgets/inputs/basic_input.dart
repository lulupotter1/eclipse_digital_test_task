import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';

class BasicInput extends StatelessWidget {
  String? hintText;
  String? Function(String?)? validator;
  TextEditingController? controller;

  BasicInput({
    this.hintText,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        style: ThemeTextStyle.R18white,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: ThemeTextStyle.R18white,
          enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4)),
              borderSide: BorderSide(width: 1, color: ThemeColors.white)),
          errorText: 'Полу пустое',
          errorStyle: ThemeTextStyle.R18black.copyWith(color: ThemeColors.red),
          filled: true,
          fillColor: ThemeColors.white,
          hintText: hintText,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        ));
  }
}
