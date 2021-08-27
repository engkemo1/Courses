import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/Drawer/MainDrawerCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonsRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonsResData.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesResData.dart';
import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesResData.dart';
import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesResData.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/EditStudProfReq.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfResData.dart';
import 'package:troom/Repo/StudProfRepo.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/StudentProfile/ShowLesson.dart';

class StudProfCont extends GetxController{
  String LOGD = 'StudProfCont-->';
  ModalHudCont modalHudController = Get.put(ModalHudCont());
   StudProfRepo _repo ;
   StudProfResData studProfResData = StudProfResData();
  var token,appLang;
   GetStorage getStorage;
   List<String> listErrorMessage = [];
   EditStudProfReq editStudProfReq;
  var name,email,phone,oldPassword,newPassword,newConfPass;
  var showView = LocalDataStrings.MyProfile;

   List<MyCoursesDataList> coursesList = [];
   List<MyClassesDataList> classesList = [];
  List<MyPrivateClassesDataList> privateClassesList = [];

  List<ShowMyClassesLessonDataList> lessonsList = [];
  var currentClassName = '';

  MainDrawerCont mainDrawerCont = Get.put(MainDrawerCont());


  @override
  void onInit() {
    // TODO: implement onInit
    _repo = StudProfRepo();
    getStorage = GetStorage();
    token = getStorage.read(LocalDataStrings.myToken);
    appLang = getStorage.read(LocalDataStrings.appLanguage);
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    if(appLang == null){
      appLang = 'ar';
      getStorage.write(LocalDataStrings.appLanguage, 'ar');
      update();
    }
    getMainProfData(token);
    super.onReady();
  }

  Future<bool> getMainProfData(token)async{
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.mainProfile(token).then((value) {
      StudProfRes studProfRes = StudProfRes.fromJson(value.data);
      if (studProfRes.status){
        studProfResData = StudProfResData.fromJson(studProfRes.data.toJson());
        update();
        print('$LOGD getMainProfData  Name ${jsonEncode(studProfResData)}');
        return true;
      }else{
        return false;
      }
    }).whenComplete((){
      modalHudController.changeisLoading(false);
      update();
    });

    return res;
  }

  Future<bool> editMainProfileData(EditStudProfReq data) async {
    listErrorMessage.clear();
    modalHudController.changeisLoading(true);
    var res = await _repo.editProfile(editStudProfReq,token).then((value) {
      StudProfRes studProfRes = StudProfRes.fromJson(value.data);
      if (studProfRes.status){
        print('$LOGD registerData  ${studProfRes.massage[0]}');
        oldPassword = '';
        newPassword = '';
        newConfPass = '';
        // if(data.newPassword.length>0  || data.newPassword.isNotEmpty){
        //   getStorage.write(LocalDataStrings.isLogged, true);
        //   mainDrawerCont.checkLogoutRes();
        //   Get.back();
        //   update();
        // }
        update();
        return true;
      }else{
        studProfRes.massage.forEach((element) {
          print('$LOGD status false  ${element}');
          listErrorMessage.add(element);
        });
        return false;
      }
    }).catchError((e){
      print('$LOGD catch Error  ${e.toString()}');
      listErrorMessage.add(e.toString());
      return false;
    }).whenComplete(() {
      oldPassword = '';
      newPassword = '';
      newConfPass = '';
      modalHudController.changeisLoading(false);
      update();
    });

    return res;
  }

  Future<void> getMyCourses(token)async{
    modalHudController.changeisLoading(true);
    listErrorMessage.clear();
    coursesList.clear();
    update();
    var res = await _repo.myCourses(token,appLang.toString()).then((value) {
      MyCoursesRes myCoursesRes = MyCoursesRes.fromJson(value.data);
      if(myCoursesRes.status){
       //TODO Has List of Courses
        final result = value.data;
        Iterable list =result['data'];
        List<MyCoursesResData> myCoursesResData =
        List<MyCoursesResData>.from(
            list.map((e) => MyCoursesResData.fromJson(e)).toList());
        coursesList = myCoursesResData.map((e) => MyCoursesDataList(data: e)).toList();
        update();
        print('$LOGD coursesList length ${coursesList.length}');
      }else{
        //TODO No List
        myCoursesRes.massage.forEach((element) {
          listErrorMessage.add(element);
        });
        update();
      }
    }).catchError((e){
      listErrorMessage.add(e.toString());
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }

  Future<void> getMyClasses(token)async{
    modalHudController.changeisLoading(true);
    listErrorMessage.clear();
    classesList.clear();
    update();
    var res = await _repo.myClasses(token,appLang.toString()).then((value) {
      MyClassesRes myClassesRes = MyClassesRes.fromJson(value.data);
      if(myClassesRes.status){
        //TODO Has List of classes
        final result = value.data;
        Iterable list =result['data'];
        List<MyClassesResData> myClassesResData =
        List<MyClassesResData>.from(
            list.map((e) => MyClassesResData.fromJson(e)).toList());

        classesList = myClassesResData.map((e) => MyClassesDataList(data: e)).toList();

        update();
        print('$LOGD ClassesList length ${classesList.length}');
      }else{
        //TODO No List
        myClassesRes.massage.forEach((element) {
          listErrorMessage.add(element);
        });
        update();
      }
    }).catchError((e){
      listErrorMessage.add(e.toString());
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }

  Future<void> getMyPrivateClasses(token)async{
    modalHudController.changeisLoading(true);
    listErrorMessage.clear();
    privateClassesList.clear();
    update();
    var res = await _repo.myPrivateClasses(token,appLang.toString()).then((value) {
      MyPrivateClassesRes myPrivateClassesRes = MyPrivateClassesRes.fromJson(value.data);
      if(myPrivateClassesRes.status){
        //TODO Has List of classes
        final result = value.data;
        Iterable list =result['data'];
        List<MyPrivateClassesResData> myClassesResData =
        List<MyPrivateClassesResData>.from(
            list.map((e) => MyPrivateClassesResData.fromJson(e)).toList());
        privateClassesList = myClassesResData.map((e) => MyPrivateClassesDataList(data: e)).toList();
        update();
        print('$LOGD getMyPrivateClasses length ${privateClassesList.length}');
      }else{
        //TODO No List
        myPrivateClassesRes.massage.forEach((element) {
          listErrorMessage.add(element);
        });
        update();
      }
    }).catchError((e){
      listErrorMessage.add(e.toString());
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }


  Future<void> getMyClassesLesson(classKey,token)async{
    modalHudController.changeisLoading(true);
    listErrorMessage.clear();
    lessonsList.clear();
    update();
    var res = await _repo.showMyClassLessons(classKey,token,appLang).then((value) {
      ShowMyClassesLessonRes myClassesLessonRes = ShowMyClassesLessonRes.fromJson(value.data);
      if(myClassesLessonRes.status){
        //TODO Has List of Lessons
        final result = value.data;
        Iterable list =result['data'];
        List<ShowMyClassesResData> myClassesResData =
        List<ShowMyClassesResData>.from(
            list.map((e) => ShowMyClassesResData.fromJson(e)).toList());
        lessonsList = myClassesResData.map((e) => ShowMyClassesLessonDataList(data: e)).toList();
        update();
        print('$LOGD getMyClassesLesson length ${lessonsList.length}');
        Get.to(()=>ShowLesson(lessonsList,currentClassName));
      }else{
        //TODO No List
        myClassesLessonRes.massage.forEach((element) {
          listErrorMessage.add(element);
        });
        update();
      }
    }).catchError((e){
      listErrorMessage.add(e.toString());
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }

  Future<void> getMyPrivateClassesLesson(classKey,token)async{
    modalHudController.changeisLoading(true);
    listErrorMessage.clear();
    lessonsList.clear();
    update();
    var res = await _repo.showMyPrivateClassLessons(classKey,token,appLang).then((value) {
      ShowMyClassesLessonRes myClassesLessonRes = ShowMyClassesLessonRes.fromJson(value.data);
      if(myClassesLessonRes.status){
        //TODO Has List of Lessons
        final result = value.data;
        Iterable list =result['data'];
        List<ShowMyClassesResData> myClassesResData =
        List<ShowMyClassesResData>.from(
            list.map((e) => ShowMyClassesResData.fromJson(e)).toList());
        lessonsList = myClassesResData.map((e) => ShowMyClassesLessonDataList(data: e)).toList();
        update();
        print('$LOGD getMyClassesLesson length ${lessonsList.length}');
        Get.to(()=>ShowLesson(lessonsList,currentClassName));
      }else{
        //TODO No List
        myClassesLessonRes.massage.forEach((element) {
          listErrorMessage.add(element);
        });
        update();
      }
    }).catchError((e){
      listErrorMessage.add(e.toString());
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
  }


  changeView(view)async {
    showView = view;
    update();
    if(showView == LocalDataStrings.MyCourses && token != null){
      await getMyCourses(token);
    }else if(showView == LocalDataStrings.MyClasses && token != null){
      await getMyClasses(token);
    }
    else if(showView == LocalDataStrings.MyPrivateClasses && token != null){
      await getMyPrivateClasses(token);
    }

  }

  showLesson(classKey,className)async{
    currentClassName = className;
    update();
    await getMyClassesLesson(classKey, token);
  }

  showPrivateLesson(classKey,className)async{
    currentClassName = className;
    update();
    await getMyPrivateClassesLesson(classKey, token);
  }

}