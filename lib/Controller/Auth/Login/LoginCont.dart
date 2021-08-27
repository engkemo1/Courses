import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/Auth/Login/LoginReqData.dart';
import 'package:troom/Models/Auth/Login/LoginRes.dart';
import 'package:troom/Models/Auth/Login/LoginResData.dart';
import 'package:troom/Models/Auth/Login/LoginResDataFalse.dart';
import 'package:troom/Models/Auth/Login/LoginResFalse.dart';
import 'package:troom/Models/Auth/ResendCode/ResendCodeRes.dart';
import 'package:troom/Models/Auth/Verification/VerificationReq.dart';
import 'package:troom/Models/Auth/Verification/VerificationRes.dart';
import 'package:troom/Repo/AuthRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Home.dart';

class LoginCont extends GetxController{
  String LOGD = 'LoginCont-->';
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
   AuthRepo _repo;
   GetStorage getStorage;
   LoginReqData loginReqData;

  var email,phone,password;
   List<String> loginErrorMessage = [];
   LoginResData loginResData = LoginResData();
   LoginResDataFalse loginResDataFalse = LoginResDataFalse();

  var verificationCode = '';
   VerificationReq codeReq;


  @override
  void onInit() {
    // TODO: implement onInit
    _repo = AuthRepo();
    getStorage = GetStorage();
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  Future<bool> loginData(LoginReqData data) async {
    loginErrorMessage.clear();
    modalHudController.changeisLoading(true);
    LoginRes loginRes;
    var res;
     res = await _repo.login(loginReqData).then((value) {
      loginRes = LoginRes.fromJson(value.data);
      if (loginRes.status){
        update();
        loginResData = LoginResData.fromJson(loginRes.data.toJson());
        print('$LOGD loginResData key ${loginResData.key}');
        return true;
      }else{
        LoginResFalse loginResFalse = LoginResFalse.fromJson(value.data);
        loginResDataFalse = LoginResDataFalse.fromJson(loginResFalse.data.toJson());
        update();
        print('$LOGD loginResData status false  key ${loginResDataFalse.userKey}');
        print('$LOGD loginResData status false  MSG ${loginResFalse.massage}');
        loginResFalse.massage.forEach((element) {
          print('$LOGD status false  $element');
          loginErrorMessage.add(element);
        });
        return false;
      }
    }).catchError((e){

      // loginRes = LoginRes.fromJson(e.data);
      print('$LOGD catch Error  ${e.toString()}');
      loginErrorMessage.add(loginRes.massage[0]);
      print('$LOGD catch Error2::  ${jsonEncode(loginRes)}');
      // LoginResFalse loginResFalse = LoginResFalse.fromJson(e);
      return false;
    }).whenComplete(() {
       modalHudController.changeisLoading(false);
       update();
    });

    return res;
  }

  Future<bool> checkLoginRes()async{
    modalHudController.changeisLoading(true);
    update();
    if(await loginData(loginReqData)){
      print('$LOGD Save Token  ${loginResData.accessToken}');
      getStorage.write(LocalDataStrings.isLogged, true);
      getStorage.write(LocalDataStrings.myToken, loginResData.accessToken);
      update();
    return true;
    }else{
    return false;
    }
  }

  Future<bool> resendCode(userKey)async{
    loginErrorMessage.clear();
    modalHudController.changeisLoading(true);
    print('$LOGD resendCode userKey  ${userKey}');
    ResendCodeRes resendCodeRes;
    var res = await _repo.resendCode(userKey).then((value) {
      resendCodeRes = ResendCodeRes.fromJson(value.data);
      if (resendCodeRes.status){
        verificationCode = '';
        print('$LOGD resendCode res massage  ${resendCodeRes.massage[0]}');
        update();
        return true;
      }else{
        verificationCode = '';
        resendCodeRes.massage.forEach((element) {
          print('$LOGD resendCode status false  ${element}');
          loginErrorMessage.add(element);
        });
        update();
        return false;
      }
    }).catchError((e){
      print('$LOGD resendCode catch Error  ${e}');
      loginErrorMessage.add(e.toString());
      verificationCode = '';
      update();
      return false;
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      verificationCode = '';
      update();
    });
    return res;
  }

  Future<bool> checkCode(VerificationReq code,userKey)async{
    loginErrorMessage.clear();
    modalHudController.changeisLoading(true);
    print('$LOGD checkCode  ${jsonEncode(code)}--> ${userKey}');
    VerificationRes verificationRes;
    var res = await _repo.checkVerificationCode(code,userKey).then((value) {
      verificationRes = VerificationRes.fromJson(value.data);
      // verificationRes = value;
      print('$LOGD checkCode value::  ${verificationRes}');
      if (verificationRes.status){
        verificationCode = '';
        print('$LOGD checkCode res massage  ${verificationRes.massage[0]}');
        getStorage.write(LocalDataStrings.isLogged, true);
        getStorage.write(LocalDataStrings.myToken, verificationRes.data.accessToken);
        update();
        return true;
      }else{
        verificationCode = '';
        verificationRes.massage.forEach((element) {
          print('$LOGD checkCode status false  ${element}');
          loginErrorMessage.add(element);
        });
        update();
        return false;
      }
    }).catchError((e){
      // verificationRes = VerificationRes.fromJson(e);
      print('$LOGD catch Error  ${e}');
      loginErrorMessage.add(e.toString());
      verificationCode = '';
      update();
      return false;
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      verificationCode = '';
      update();
    });
    return res;
  }



}