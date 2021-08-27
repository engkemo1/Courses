import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_zoom_plugin/zoom_options.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Models/ZoomMeeting/ShowMeeting/ShowMeetingRes.dart';
import 'package:troom/Models/ZoomMeeting/ShowMeeting/ShowMeetingResData.dart';
import 'package:troom/Models/ZoomMeeting/ZoomCredential/ZoomCredRes.dart';
import 'package:troom/Models/ZoomMeeting/ZoomCredential/ZoomCredResData.dart';
import 'package:troom/Repo/ZoomRepo.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class ZoomCont extends GetxController{
  String LOGD = 'ZoomCont-->';
   ModalHudCont modalHudController = Get.put(ModalHudCont());
  var _lessonKey;
   ZoomRepo _repo;
   GetStorage getStorage;
  var token;
   ShowMeetingResData showMeetingResData = ShowMeetingResData();
   ZoomCredResData zoomCredResData = ZoomCredResData();


   Timer timer;

  ZoomCont(this._lessonKey);

  ZoomOptions zoomOptions;
  ZoomMeetingOptions meetingOptions;



  bool isMeetingEnded(String status) {
    var result = false;

    if (Platform.isAndroid)
      result = status == "MEETING_STATUS_DISCONNECTING" || status == "MEETING_STATUS_FAILED";
    else
      result = status == "MEETING_STATUS_IDLE";

    return result;
  }



@override
  void onInit() async{
    // TODO: implement onInit
    _repo = ZoomRepo();
    getStorage = GetStorage();
    token = getStorage.read(LocalDataStrings.myToken);
    if(_lessonKey!=null){
      await getZoomCredential(token);
    }
    super.onInit();
  }

  Future<bool> getShowMeeting(lessonKey,token)async{
    // modalHudController.changeisLoading(true);
    // update();
    var res = await _repo.showMeeting(lessonKey, token).then((value) {
      ShowMeetingRes courseDetailsRes = ShowMeetingRes.fromJson(value.data);
      if (courseDetailsRes.status){
        showMeetingResData = ShowMeetingResData.fromJson(courseDetailsRes.data.toJson());
        update();
        print('$LOGD getShowMeeting  Res ${jsonEncode(showMeetingResData)}');
        update();
        return true;

      }else{
        return false;
      }
    }).whenComplete((){
      modalHudController.changeisLoading(false);



      this.meetingOptions = new ZoomMeetingOptions(
          userId: showMeetingResData.nickname,
          meetingId: showMeetingResData.meetingId.toString(),
          meetingPassword: showMeetingResData.password,
          disableDialIn: "true",
          disableDrive: "true",
          disableInvite: "true",
          disableShare: "true",
          noAudio: "false",
          noDisconnectAudio: "false"
      );

      update();
    });

    return res;
  }

  Future<bool> getZoomCredential(token)async{

    var res = await _repo.zoomCredential(token).then((value) {
      ZoomCredRes courseDetailsRes = ZoomCredRes.fromJson(value.data);
      if (courseDetailsRes.status){
        zoomCredResData = ZoomCredResData.fromJson(courseDetailsRes.data.toJson());
        update();
        print('$LOGD getZoomCredential  Res ${jsonEncode(zoomCredResData)}');

        this.zoomOptions = new ZoomOptions(
          domain: "Api.aisent.net",
          appKey: '7aOXfKL0Tt-XXOLToV8Ghg', // Replace with with key got from the Zoom Marketplace
          appSecret: 'XQ8VRIhCfwSe0l8I9oBm0tKyK4sRev63JZC2', // Replace with with secret got from the Zoom Marketplace
        );

        update();
        return true;
      }else{
        return false;
      }
    }).whenComplete((){
      modalHudController.changeisLoading(false);

      this.zoomOptions = new ZoomOptions(
        domain: "zoom.us",
        appKey: zoomCredResData.sdkKey, // Replace with with key got from the Zoom Marketplace
        appSecret: zoomCredResData.sdkSecret, // Replace with with secret got from the Zoom Marketplace
      );

      update();
       getShowMeeting(_lessonKey, token);
    });

    return res;
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    // Get.back();
  }

}