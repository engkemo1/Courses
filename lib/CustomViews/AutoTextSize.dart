import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:troom/Util/ConstStyles.dart';

class AutoTextSize extends StatelessWidget {
  String text;
  double size;
  Color textColor;
  FontWeight fontWeight;


  AutoTextSize({this.text, this.size,this.textColor,this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.start ,
      style: TextStyle(
        fontSize: size == null ? 14 : size,
        color: textColor == null ? ConstStyles.TextColor :textColor,
        fontWeight:fontWeight == null ?  FontWeight.normal : fontWeight,
      ),
      minFontSize: 8,
      stepGranularity: 1,
      // maxLines: 3,
    );
  }
}
