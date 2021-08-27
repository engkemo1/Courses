import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Models/Auth/TokenStatus/CheckRes.dart';
import 'package:troom/Models/Auth/TokenStatus/CheckResData.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Home.dart';
import 'package:video_player/video_player.dart';

class SplashCont extends GetxController{
  String LOGD = 'SplashCont-->';
   VideoPlayerController controller;
  Future<void> initializeVideoPlayerFuture ;
  String token ;
  var isLogged;
   GetStorage getStorage;
  var _dio;
   List<String> errorsMessage = [];

  @override
  void onInit() async{
    // TODO: implement onInit
    getStorage = GetStorage();
    _dio = Dio();
    token = await getStorage.read(LocalDataStrings.myToken);
    isLogged =await getStorage.read(LocalDataStrings.isLogged);
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    print('$LOGD onReady myToken  ${token}');
    await prepareVideo();
    await checkToken(token);
    super.onReady();
  }

  
   prepareVideo()async{
    controller = VideoPlayerController.asset(
        'assets/video/troom.mp4',
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        ),
    );
    initializeVideoPlayerFuture = controller.initialize();
    controller.setLooping(true);
    controller.play();
/*    controller.addListener(() async{
      if (!controller.value.isPlaying ){
        if(controller.value.duration.inSeconds ==controller.value.position.inSeconds){
          print('$LOGD ------> videoEnded ${controller.value.isPlaying.toString()}');
          await checkToken(token);
          update();
        }
      }
    });*/
    update();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    controller.dispose();
    // controller.pause();
    // controller.setLooping(false);
    update();
    super.onClose();
  }

  Future<dynamic> repoCheckToken(token)async{
    var response;
    try{
      response = await this._dio.post(
        EndPoints.CheckToken + token,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD repoCheckToken response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD repoCheckToken error : ${e.response.toString()}');
      return e.response;
    }
  }

  Future<void> checkToken(token) async {
    print('$LOGD checkToken myToken  ${token}');
    errorsMessage.clear();

    if(token!=null){
      var res = await repoCheckToken(token).then((value) {
        CheckRes checkRes = CheckRes.fromJson(value.data);
        CheckResData checkResData = CheckResData.fromJson(checkRes.data.toJson());
        if(checkResData.tokenExpire){
          print('$LOGD checkToken  ${checkRes.massage}');
          getStorage.write(LocalDataStrings.isLogged, true);
          // controller.dispose();
          // Get.back();
          // Get.offAllNamed(Home.Id);
          update();
          return true;
        }else{
          getStorage.remove(LocalDataStrings.myToken);
          getStorage.write(LocalDataStrings.isLogged,false);
          // controller.dispose();
          // Get.back();
          // Get.offAllNamed(Home.Id);
          print('$LOGD checkToken  ${checkRes.massage}');
          update();
          return false;
        }
      }).catchError((e){
        print('$LOGD catch Error  ${e.toString()}');
        errorsMessage.add(e.toString());
        return false;
      }).whenComplete(() {
        controller.setLooping(false);
        // controller.pause();
        update();
        controller.addListener(() async{
          if (!controller.value.isPlaying ){
            if(controller.value.duration.inSeconds ==controller.value.position.inSeconds){
              print('$LOGD ------> videoEnded ${controller.value.isPlaying.toString()}');
              Get.offAllNamed(Home.Id);
              update();
            }
          }
        });
        update();
      });

      // return true;
    }

    else {
    controller.setLooping(false);
    // controller.pause();
    update();
            controller.addListener(() async{
      if (!controller.value.isPlaying ){
        if(controller.value.duration.inSeconds ==controller.value.position.inSeconds){
          print('$LOGD ------> videoEnded ${controller.value.isPlaying.toString()}');
          Get.offAllNamed(Home.Id);
          update();
        }
      }
    });
    update();

    }

  }



}