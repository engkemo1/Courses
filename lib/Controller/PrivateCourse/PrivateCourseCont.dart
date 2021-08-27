import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/OurTeachers/OurTeacherRes.dart';
import 'package:troom/Models/OurTeachers/OurTeachersDataList.dart';
import 'package:troom/Models/OurTeachers/OurTeachersResData.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReq.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReqRes.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReqResData.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesDataList.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesRes.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesResData.dart';
import 'package:troom/Repo/HomeRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class PrivateCourseCont extends GetxController{
  String LOGD = 'PrivateCourseCont';

  List<OurTeachersDataList> ourTeachersList = [];
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
  HomeRepo _repo;
  GetStorage getStorage;
  var myToken,appLang;
  List<String> errorsMessage = [];

  //TODO Private Course
  String selectedTeacher ,selectedCourse,selectedSat,selectedSun,selectedMon,selectedTue,selectedWed,
      selectedThu,selectedFri;
  var teacherId,courseId,startDate,note,satTime,sunTime,monTime,tueTime,wedTime,thuTime,friTime;
  PrivateCourseReqResData privateCourseReqResData = PrivateCourseReqResData();
  PrivateCourseReq privateCourseReq ;
  List<TeachersCoursesDataList> teachersCoursesList = List<TeachersCoursesDataList>();

  @override
  void onInit() async{
    // TODO: implement onInit
    _repo = HomeRepo();
    getStorage = GetStorage();
    if(getStorage.read(LocalDataStrings.myToken) != null){
      myToken = getStorage.read(LocalDataStrings.myToken);
      print('$LOGD  LoginStatus:: ${myToken}');
    }
    appLang = await getStorage.read(LocalDataStrings.appLanguage);
    if(appLang == null){
      appLang = 'ar';
      Get.updateLocale(Locale('ar'));
      update();
    }else{
      Get.updateLocale(Locale(appLang));
      update();
    }

    super.onInit();
  }

  @override
  void onReady() async{
    print('$LOGD onReady---------');
    await getOurTeachersData();
      update();

    super.onReady();
  }

  Future<bool> getOurTeachersData()async{
    // modalHudController.changeisLoading(true);
    update();
    var res = await _repo.ourTeachers().then((value) {
      OurTeacherRes ourTeacherRes = OurTeacherRes.fromJson(value.data);
      if (ourTeacherRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<OurTeachersResData> ourTeachersResData =
        List<OurTeachersResData>.from(
            list.map((e) => OurTeachersResData.fromJson(e)).toList());
        ourTeachersList = ourTeachersResData.map((e) => OurTeachersDataList(data: e)).toList();
        update();
        print('$LOGD ourTeachersList length ${ourTeachersList.length}');
        return true;
      }else{
        return false;
      }
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    return res;
  }

  Future<bool> getTeacherCourses(teacherKey)async{

    modalHudController.changeisLoading(true);
    var res = await _repo.teacherCourses(teacherKey, myToken, appLang).then((value) {
      TeachersCoursesRes ourTeacherRes = TeachersCoursesRes.fromJson(value.data);
      if (ourTeacherRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<TeachersCoursesResData> ourTeachersResData =
        List<TeachersCoursesResData>.from(
            list.map((e) => TeachersCoursesResData.fromJson(e)).toList());
        teachersCoursesList = ourTeachersResData.map((e) => TeachersCoursesDataList(data: e)).toList();
        modalHudController.changeisLoading(false);
        update();
        print('$LOGD getTeacherCourses length ${teachersCoursesList.length}');
        return true;
      }else{
        return false;
      }
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    }).catchError((e){
      print('$LOGD getTeacherCourses Error ${e.toString()}');
      teachersCoursesList = null;
    });

    return res;
  }

  preparePrivateCourseReq()async{
    privateCourseReq = PrivateCourseReq(teacherId: teacherId,courseId: courseId,startDate: startDate,note: note,
        sat: satTime,sun: sunTime,mon: monTime,tue: tueTime,wed: wedTime,thu: thuTime,fri: friTime);
    print('$LOGD preparePrivateCourseReq: ${jsonEncode(privateCourseReq)}');
    await sendPrivateReq(privateCourseReq, myToken, appLang);
  }

  Future<void> sendPrivateReq(req,token,appLang)async{
    errorsMessage.clear();
    modalHudController.changeisLoading(true);
    update();
    await _repo.sendPrivateReq(req,token,appLang).then((value) {
      PrivateCourseReqRes quizResultRes = PrivateCourseReqRes.fromJson(value.data);
      // PrivateCourseReqRes quizResultRes = value;
      print('$LOGD sendPrivateReq res ${quizResultRes}');
      if(quizResultRes.status){
        privateCourseReqResData = PrivateCourseReqResData.fromJson(quizResultRes.data.toJson());
        print('$LOGD sendPrivateReq ResData ${privateCourseReqResData}');
        update();
        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(txt: 'RequestSentSuccessfully'.tr,
              txtAlign: TextAlign.center,));
        update();
      }else{
        quizResultRes.massage.forEach((element) {
          errorsMessage.add(element);
          update();
        });
        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(txt: errorsMessage[0],
              txtAlign: TextAlign.center,));
      }
    }).catchError((e){
      errorsMessage.add(e.toString());
      // PrivateCourseReqRes quizResultRes = e;
      update();
      print('$LOGD sendPrivateReq catchError ${e}');
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      // clearPrivateCourseScreen();
      update();
    });
  }

  changeTeacher(teacherName,teacherKey)async{
    teachersCoursesList = List<TeachersCoursesDataList>();
    selectedCourse = null;
    selectedTeacher = teacherName;
    teacherId = teacherKey;
    Get.back();
    await getTeacherCourses(teacherKey);
    update();
  }

  changeCourse(courseName,id)async{
    // selectedCourse = null;
    teachersCoursesList.forEach((element) {
      if(element.key == id){
        selectedCourse = element.name;
        update();
      }
    });
    // selectedCourse = teachersCoursesList.isEmpty ? 'Select ' : teachersCoursesList.firstWhere((element) => element.name == courseName);
    courseId = id;
    print('$LOGD changeCourse: ${this.courseId}');
    print('$LOGD changeCourse: $selectedCourse');
    update();
    Get.back();

  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.Hm();  //"6:00 AM"
    return format.format(dt);
  }

  String formatTimeOfDayAmPm(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm();  //"6:00 AM"
    return format.format(dt);
  }

  Future<void> selectDate(context) async {
    // DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    DateTime now = DateTime.now();
    final DateTime pickedDate = await showDatePicker(
      // locale: const Locale('ar','EG'),
        context: context,
        initialDate: now,
        firstDate: DateTime(2021),
        lastDate: DateTime(2050));
    if (pickedDate != null){
      startDate =  dateFormat.format(pickedDate);
      print('$LOGD selectedDate:: ${startDate}');
      // currentDate = formatter.format(pickedDate);
      update();
    }else{
      startDate =  '';
      print('$LOGD selectedDate:: ${startDate}');
      update();
    }
    // print('$LOGD dateForAvailableTimes:: $dateSession');
  }

  Future<void> selectSatTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      satTime =  formatTimeOfDay(pickedDate);
      selectedSat = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectSatTime:: ${satTime}');
      update();
    }else{
      satTime =  '';
      selectedSat = '';
      print('$LOGD selectSatTime:: ${satTime}');
      update();
    }
  }

  Future<void> selectSunTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      sunTime =  formatTimeOfDay(pickedDate);
      selectedSun = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectSunTime:: ${sunTime}');
      update();
    }else{
      sunTime =  '';
      selectedSun = '';
      print('$LOGD selectSunTime:: ${sunTime}');
      update();
    }
  }

  Future<void> selectMonTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      monTime =  formatTimeOfDay(pickedDate);
      selectedMon = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectMonTime:: ${selectedMon}');
      update();
    }else{
      monTime =  '';
      selectedMon = '';
      print('$LOGD selectMonTime:: ${selectedMon}');
      update();
    }
  }

  Future<void> selectTueTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      tueTime =  formatTimeOfDay(pickedDate);
      selectedTue = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectTueTime:: ${tueTime}');
      update();
    }else{
      tueTime =  '';
      selectedTue = '';
      print('$LOGD selectTueTime:: ${tueTime}');
      update();
    }
  }

  Future<void> selectWedTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      wedTime =  formatTimeOfDay(pickedDate);
      selectedWed = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectWedTime:: ${wedTime}');
      update();
    }else{
      wedTime =  '';
      selectedWed = '';
      print('$LOGD selectWedTime:: ${wedTime}');
      update();
    }
  }

  Future<void> selectThuTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      thuTime =  formatTimeOfDay(pickedDate);
      selectedThu = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectThuTime:: ${thuTime}');
      update();
    }else{
      thuTime =  '';
      selectedThu = '';
      print('$LOGD selectThuTime:: ${thuTime}');
      update();
    }
  }

  Future<void> selectFriTime(context) async {
    final  pickedDate = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedDate != null){
      friTime =  formatTimeOfDay(pickedDate);
      selectedFri = formatTimeOfDayAmPm(pickedDate);
      print('$LOGD selectFriTime:: ${friTime}');
      update();
    }else{
      friTime =  '';
      selectedFri = '';
      print('$LOGD selectFriTime:: ${friTime}');
      update();
    }
  }

}