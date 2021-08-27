import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Models/BuyCourse/BuyCourseRes.dart';
import 'package:troom/Models/CourseDetails/CourseDetailsResData.dart';
import 'package:troom/Models/LiveCourseDetails/LiveCourseDetailsRes.dart';
import 'package:troom/Models/LiveCourseDetails/LiveCourseDetailsResData.dart';
import 'package:troom/Repo/CourseDetailsRepo.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class LiveCourseDetailsCont extends GetxController{
  String LOGD = 'LiveCourseDetailsCont-->';
  Map<String,dynamic> dataOfCourseDes;

  var courseKey,token,appLang;
   ModalHudCont modalHudController = Get.put(ModalHudCont());
   CourseDetailsRepo _repo;
   GetStorage getStorage;
   LiveCourseDetailsResData courseDetailsResData = LiveCourseDetailsResData();

  LiveCourseDetailsCont(this.courseKey){
    print('$LOGD ConstructorCourseKey $courseKey');
    _repo = CourseDetailsRepo();
    getStorage = GetStorage();
    token = getStorage.read(LocalDataStrings.myToken);
    appLang = getStorage.read(LocalDataStrings.appLanguage);
    update();
    if(appLang == null ){
      appLang = 'ar';
      getStorage.write(LocalDataStrings.appLanguage, 'ar');
      update();
    }

  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async{
    // TODO: implement onReady
    print('$LOGD Ready...');
    if(appLang == null){
      appLang = 'ar';
      update();
    }
    if(courseKey != null){
      modalHudController.changeisLoading(true);
      update();
      await liveCourseDetailsData(courseKey.toString(), token.toString()).whenComplete(() {
        modalHudController.changeisLoading(false);
        update();
      });
    update();
    }
    super.onReady();
  }

  //get description of live course
  Future LiveCourseDesData()async{
    // modalHudController.changeisLoading(true);
    // update();
    token = getStorage.read(LocalDataStrings.myToken);
    try {
      var res = await Dio().get("https://Api.aisent.net/api/liveCourseDetails/${this.courseKey}?token=$token");

      print("This is the response of the LiveCourseDesData #######${res.data}");

      dataOfCourseDes = await res.data;
      update();

      print("This is the message of the LiveCourseDesData #######${res.data}");


      return "success";
    } catch(e){
      print(e);
    }
  }

  Future<void> liveCourseDetailsData(courseKey,token)async{
    courseDetailsResData = LiveCourseDetailsResData();
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.liveCourseDetails(courseKey, token,appLang.toString()).then((value) {
      LiveCourseDetailsRes courseDetailsRes = LiveCourseDetailsRes.fromJson(value.data);
      if (courseDetailsRes.status){
        courseDetailsResData = LiveCourseDetailsResData.fromJson(courseDetailsRes.data.toJson());
        update();
        print('$LOGD liveCourseDetailsData  res:: ${jsonEncode(courseDetailsResData)}');
        // return true;
      }else{
        // return false;
      }
    });

  }

  Future<String> getPauPalLink(courseKey,token)async{
    modalHudController.changeisLoading(true);
    update();
    BuyCourseRes courseDetailsRes;
    var res = await _repo.buyCourse(courseKey, token).then((value) {
      courseDetailsRes = BuyCourseRes.fromJson(value.data);
      if (courseDetailsRes.status){
        // Get.back();
        print('$LOGD getPauPalLink   ${courseDetailsRes.data.link}');

        liveCourseDetailsData(courseKey, token);
        update();
        return courseDetailsRes.data.link;
      }else{
        return null;
      }
    }).whenComplete((){
      modalHudController.changeisLoading(false);
      update();
    });
    return courseDetailsRes.data.link.toString();
  }



  @override
  void onClose() {
    // TODO: implement onClose
    courseDetailsResData = LiveCourseDetailsResData();
    super.onClose();
  }
}