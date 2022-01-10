import 'package:flutter/material.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_colors.dart';
import 'package:eclipse_digital_test_task/data/utils/theme_style.dart';

class ScaffoldWidget extends StatefulWidget {
  Widget body;
  Color? bgColor;
  String title;
  ScaffoldWidget(
      {Key? key, required this.body, required this.title, this.bgColor})
      : super(key: key);

  @override
  _ScaffoldWidgetState createState() => _ScaffoldWidgetState();
}

class _ScaffoldWidgetState extends State<ScaffoldWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ThemeColors.blue,
        title: Expanded(
          child: Text(
            widget.title,
            style: ThemeTextStyle.R18white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
            width: MediaQuery.of(context).size.width, child: widget.body),
      ),
      backgroundColor: widget.bgColor ?? ThemeColors.white,
    );
  }
}
