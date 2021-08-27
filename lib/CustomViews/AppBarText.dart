import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';

class AppBarText extends StatelessWidget {
  final String txt;


  AppBarText({this.txt});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: ConstStyles.WhiteColor,
        fontWeight: FontWeight.bold,
      ),
      minFontSize: 14,
      stepGranularity: 1,
      maxLines: 2,
    );
  }
}
