import 'package:flutter/material.dart';

class LogoContainer extends StatelessWidget {
  final Color colors;
  final String url;
  final BoxFit boxFit;


  LogoContainer({this.colors,this.url,this.boxFit});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: colors,
          image: DecorationImage(
            image: AssetImage("assets/images/logo.png"),
            fit: boxFit == null ? BoxFit.contain : boxFit,
          ),
        ),
        );
  }
}



