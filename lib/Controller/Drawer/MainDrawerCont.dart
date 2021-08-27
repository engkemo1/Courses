import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/Auth/Logout/LogoutRes.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Home.dart';
import 'package:troom/View/Splash.dart';


class MainDrawerCont extends GetxController {
   var _dio;
   String LOGD = 'DrawerCont-->';
    List<String> logoutErrorMessage = [];
   final ModalHudCont modalHudController = Get.put(ModalHudCont());
   HomeCont homeCont = Get.put(HomeCont());
    GetStorage getStorage;
   var token,isLogged;
   var appLang;

   @override
  void onInit() async{
    // TODO: implement onInit
    _dio = Dio();
    getStorage = GetStorage();
    token = await getStorage.read(LocalDataStrings.myToken);
    isLogged = await getStorage.read(LocalDataStrings.isLogged);
    appLang = await getStorage.read(LocalDataStrings.appLanguage);
    if(appLang == null){
      appLang = 'ar';
      Get.updateLocale(Locale(appLang));
      update();
    }
    Get.updateLocale(Locale(appLang));
    update();
    // print('$LOGD $isLogged');

    super.onInit();
  }

  changeLang(value) async{
     appLang = value;
     await getStorage.write(LocalDataStrings.appLanguage, value);
     Get.updateLocale(Locale(appLang));
     Get.back();
     // await homeCont.fireMethods();
     await FlutterRestart.restartApp();
     update();
  }

  @override
  void onReady() {
    // TODO: if true
    if(isLogged!= null){
      //TODO check token expire or not

    }
    super.onReady();
  }

  Future<bool> logout(token) async {
    logoutErrorMessage.clear();
    modalHudController.changeisLoading(true);
    var res = await repoLogout(token).then((value) {
      LogoutRes logoutRes = LogoutRes.fromJson(value.data);
      if (logoutRes.status){
        FlutterRestart.restartApp();
        update();
        print('$LOGD loginResData  ${logoutRes.massage}');
        return true;
      }else{
        logoutRes.massage.forEach((element) {
          print('$LOGD status false  $element');
          logoutErrorMessage.add(element);
        });
        return false;
      }
    }).catchError((e){
      print('$LOGD catch Error  ${e.toString()}');
      logoutErrorMessage.add(e.toString());
      return false;
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    return res;
  }

  Future<bool> checkLogoutRes()async{
    modalHudController.changeisLoading(true);
    update();
    print('$LOGD  Logged out my Token ${getStorage.read(LocalDataStrings.myToken)}');

    if(getStorage.read(LocalDataStrings.myToken)!=null){
      if(await logout(getStorage.read(LocalDataStrings.myToken))){
        isLogged = getStorage.write(LocalDataStrings.isLogged, false);
        token = getStorage.remove(LocalDataStrings.myToken);
        update();
        print('$LOGD  Logged out}');
        // Get.back();
        // Get.offAllNamed(Splash.Id);
return true;
      }else{
        print('$LOGD  Logged out ==> ${logoutErrorMessage[0]}');
        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(txt: logoutErrorMessage[0],
              txtAlign: TextAlign.center,));
        return false;
      }
    }else {
      return false;
    }

  }

  Future<dynamic> repoLogout(token)async{
    var response;
    try{
      response = await this._dio.post(
        EndPoints.Logout + token,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD logout response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD logout error : ${e.response.toString()}');
      return e.response;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    print('$LOGD on close-------');
    super.onClose();
  }
}