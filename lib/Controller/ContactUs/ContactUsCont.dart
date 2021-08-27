import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/ContactUs/ContactUsData/ContactUsRes.dart';
import 'package:troom/Models/ContactUs/ContactUsData/ContactUsResData.dart';
import 'package:troom/Models/ContactUs/ContactUsMassege/ContactUsMsgRes.dart';
import 'package:troom/Models/ContactUs/ContactUsMassege/ContactUsMsgResData.dart';
import 'package:troom/Models/ContactUs/ContactUsMassege/MessageReq.dart';
import 'package:troom/Repo/ContactUsRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class ContactUsCont extends GetxController{
  String LOGD = 'ContactUsCont-->' ;
  var name,massage;
   ContactUsRepo _repo;
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
   ContactUsResData contactUsResData = ContactUsResData();
   List<String> errors = [];
   ContactUsMsgResData contactUsMsgResData = ContactUsMsgResData();
   MessageReq messageReq;
  var token;
  var getStorage = GetStorage();

   GoogleMapController googleMapController;
   Marker locationMarker;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _repo = ContactUsRepo();
    token = getStorage.read(LocalDataStrings.myToken);
    addMarker(LatLng(30.0444, 31.2357));
  }

  @override
  void onReady() async{
    // TODO: implement onReady
    super.onReady();
    await getContactUsData();
  }

  Future<void> getContactUsData()async{
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.contactUsData().then((value) {
      ContactUsRes contactUsRes = ContactUsRes.fromJson(value.data);
      if (contactUsRes.status){
        contactUsResData = ContactUsResData.fromJson(contactUsRes.data.toJson());
        update();
        print('$LOGD getContactUsData  data ${contactUsResData.email}');
        if(contactUsResData.location.length >=1){
          // addMarker(contactUsResData.location!);
        }else{
          addMarker(LatLng(30.0444, 31.2357));
        }
      }else{
        contactUsRes.massage.forEach((element) {
          errors.add(element);
          update();
        });
        update();
      }
    }).catchError((e){
      print('$LOGD getContactUsData  error ${e.response}');
      ContactUsRes contactUsRes = ContactUsRes.fromJson(e.data);
      print('$LOGD getContactUsData  error22 ${jsonEncode(contactUsRes)}');
      // errors.add(e);
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

  }

  Future<void> sendMessage(MessageReq messageReq,token)async{
    errors.clear();
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.sendMessage(messageReq,token).then((value) {
      ContactUsMsgRes quizResultRes = ContactUsMsgRes.fromJson(value.data);
      if(quizResultRes.status){
        contactUsMsgResData = ContactUsMsgResData.fromJson(quizResultRes.data.toJson());
        print('$LOGD sendMessage ResData ${contactUsMsgResData}');
        update();
        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(txt: 'MessageSentSuccessfully'.tr,
              txtAlign: TextAlign.center,));
        update();
      }else{
        quizResultRes.massage.forEach((element) {
          errors.add(element);
          update();
        });
        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(txt: errors[0],
              txtAlign: TextAlign.center,));
      }
    }).catchError((e){
      errors.add(e.toString());
      update();
      print('$LOGD sendMessage catchError ${e}');
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }

  prepareMsgReq(){
    if(name != null && massage != null && token != null){
      messageReq = MessageReq(name: name , note: massage);
      sendMessage(messageReq, token);
    }else{
      Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
          colorText: ConstStyles.WhiteColor,
          titleText: CustomText(txt: 'AllDataRequired'.tr,
            txtAlign: TextAlign.center,));
    }
  }

  addMarker(LatLng pos){
   locationMarker = Marker(
       markerId: MarkerId('locationMarker'),
     infoWindow: InfoWindow(title: 'Our Location'),
     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
     position:pos,
   );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    googleMapController.dispose();
    update();
    super.onClose();
  }

}