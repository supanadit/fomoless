import 'package:flutter/material.dart';

class TimeUnitWidget extends StatelessWidget {
  final String value;
  final double fontSize;
  const TimeUnitWidget({super.key, required this.value, this.fontSize = 60.0});

  @override
  Widget build(BuildContext context) {
    return Text(value, style: TextStyle(fontSize: fontSize));
  }
}
