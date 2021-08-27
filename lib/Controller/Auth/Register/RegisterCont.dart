import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/Auth/Register/RegisterReqData.dart';
import 'package:troom/Models/Auth/Register/RegisterRes.dart';
import 'package:troom/Models/Auth/Register/RegisterResData.dart';
import 'package:troom/Models/Auth/ResendCode/ResendCodeRes.dart';
import 'package:troom/Models/Auth/Verification/VerificationReq.dart';
import 'package:troom/Models/Auth/Verification/VerificationRes.dart';
import 'package:troom/Repo/AuthRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Home.dart';

class RegisterCont extends GetxController{
  String LOGD = 'RegisterCont-->';
  var userType = 'student';
   AuthRepo _repo;
   GetStorage getStorage;
   RegisterReqData registerReqData;
   VerificationReq codeReq;
   RegisterResData registerResData = RegisterResData();
  var name,email,countryCode,phone,password,confirmPassword,type;
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
   List<String> registerErrorMessage = [];
  var verificationCode = '';


  @override
  void onInit() {
    // TODO: implement onInit
    _repo = AuthRepo();
    getStorage = GetStorage();
    super.onInit();
  }


  @override
  void onReady() {

    super.onReady();

  }

  Future<String> getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'US');
    this.phone = number;
    update();
    return this.phone;
  }

/*
  changeRadioGroupValue(value){
    radioGroupValue = value;
    update();
  }
*/

  bool checkData(RegisterReqData data){
    if(data.name.isEmpty || data.phone == null || data.email.isEmpty ){
      Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
          colorText: ConstStyles.WhiteColor,
          titleText: CustomText(txt: 'AllDataRequired'.tr,
            txtAlign: TextAlign.center,));
      return false;
    }else{
      return true;
    }
  }

  Future<bool> registerData(RegisterReqData data) async {
    registerErrorMessage.clear();
    modalHudController.changeisLoading(true);
    update();
    if(checkData(data)){
      var res = await _repo.register(registerReqData).then((value) {
        RegisterRes registerRes = RegisterRes.fromJson(value.data);
        if (registerRes.status){
          print('$LOGD registerData  ${registerRes.massage[0]}');
          registerResData = RegisterResData.fromJson(registerRes.data.toJson());
          print('$LOGD registerResData key  ${registerResData.key}');
          update();
          return true;
        }else{
          registerRes.massage.forEach((element) {
            print('$LOGD status false  ${element}');
            registerErrorMessage.add(element);
          });
          return false;
        }
      }).catchError((e){
        print('$LOGD catch Error  ${e.toString()}');
        registerErrorMessage.add(e.toString());
        return false;
      }).whenComplete(() {
        modalHudController.changeisLoading(false);
        update();
      });
      return res;
    }else{
      modalHudController.changeisLoading(false);
      update();
      return false;
    }

  }

  Future<bool> checkCode(VerificationReq code,userKey)async{
    registerErrorMessage.clear();
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
          registerErrorMessage.add(element);
        });
        update();
        return false;
      }
    }).catchError((e){
      // verificationRes = VerificationRes.fromJson(e);
      print('$LOGD catch Error  ${e}');
      registerErrorMessage.add(e.toString());
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

  Future<bool> resendCode(userKey)async{

    registerErrorMessage.clear();
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
          registerErrorMessage.add(element);
        });
        update();
        return false;
      }
    }).catchError((e){
      print('$LOGD resendCode catch Error  ${e}');
      registerErrorMessage.add(e.toString());
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