import 'dart:io';

import 'package:flutter/material.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:transparent_image/transparent_image.dart';

class CustomNetworkImage extends StatelessWidget {
  var url;
  var radius;
  Function newImage;


  CustomNetworkImage({this.url,this.radius,this.newImage});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius == null ? 10 : radius),
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.fill,
                imageScale: 1.0,
                placeholder: kTransparentImage,
                image: url ,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget myImage(url){
    return Image.file(File(url));
  }
}
