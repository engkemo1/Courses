import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/Splash/SplashCont.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:video_player/video_player.dart';

class Splash extends GetView<SplashCont> {
  static const Id = 'SplashScreen';
   SplashCont _splashCont = Get.put(SplashCont());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GetBuilder<SplashCont>(
        builder: (_){
         return Container(
           width: width,
           height: height,
           color: ConstStyles.VideoColor,
            child: Center(
              child: FutureBuilder(
                future: _splashCont.initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return AspectRatio(
                        aspectRatio: _splashCont.controller.value.aspectRatio,
                        child: VideoPlayer(_splashCont.controller));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          );
        },
      )
    );
  }
}
