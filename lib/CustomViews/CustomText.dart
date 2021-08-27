import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';

class CustomText extends StatelessWidget {
  final String txt;
  final double fontSize;
  final Color txtColor;
  final TextAlign txtAlign;
  final FontWeight fontWeight;



  CustomText({this.txt,this.fontSize,this.txtColor,this.txtAlign,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      txt,
      textAlign: txtAlign == null ? TextAlign.start : txtAlign,
      style: TextStyle(
        fontSize: fontSize == null ? 16 : fontSize,
        color: txtColor == null ? ConstStyles.WhiteColor : txtColor,
        fontWeight:fontWeight == null ? FontWeight.bold : fontWeight,
      ),
      minFontSize: 8,
      stepGranularity: 1,
      maxLines: 3,
    );
  }
}
