import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitAnsAllReq.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsReq.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/Analysis/AnalysisRes.dart';
import 'package:troom/Models/Analysis/AnalysisResData.dart';
import 'package:troom/Models/Auth/TokenStatus/CheckRes.dart';
import 'package:troom/Models/Auth/TokenStatus/CheckResData.dart';
import 'package:troom/Models/Category/CategoryDataList.dart';
import 'package:troom/Models/Category/CategoryRes.dart';
import 'package:troom/Models/Category/CategoryResData.dart';
import 'package:troom/Models/Courses/CoursesDataList.dart';
import 'package:troom/Models/Courses/CoursesRes.dart';
import 'package:troom/Models/Courses/CoursesResData.dart';
import 'package:troom/Models/Features/FeaturesDataList.dart';
import 'package:troom/Models/Features/FeaturesRes.dart';
import 'package:troom/Models/Features/FeaturesResData.dart';
import 'package:troom/Models/LiveCourses/LiveCoursesDataList.dart';
import 'package:troom/Models/LiveCourses/LiveCoursesRes.dart';
import 'package:troom/Models/LiveCourses/LiveCoursesResData.dart';
import 'package:troom/Models/OurTeachers/OurTeacherRes.dart';
import 'package:troom/Models/OurTeachers/OurTeachersDataList.dart';
import 'package:troom/Models/OurTeachers/OurTeachersResData.dart';
import 'package:troom/Models/PlacementKey/GetPlacementExam/GetPlacementExamRes.dart';
import 'package:troom/Models/PlacementKey/GetPlacementExam/GetPlacementExamResData.dart';
import 'package:troom/Models/PlacementKey/GetPlacementKey/GetPlacementTestKeyRes.dart';
import 'package:troom/Models/PlacementKey/GetPlacementKey/GetPlacementTestKeyResData.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsReq.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsRes.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsResData.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfRes.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfResData.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReq.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReqRes.dart';
import 'package:troom/Models/ReqPrivateCourse/PrivateCourseReqResData.dart';
import 'package:troom/Models/Slider/SliderDataList.dart';
import 'package:troom/Models/Slider/SliderRes.dart';
import 'package:troom/Models/Slider/SliderResData.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesDataList.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesRes.dart';
import 'package:troom/Models/TeachersCourses/TeachersCoursesResData.dart';
import 'package:troom/Repo/HomeRepo.dart';
import 'package:troom/Repo/StudProfRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:video_player/video_player.dart';

class HomeCont extends GetxController{
  String LOGD = 'HomeCont-->';
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
   HomeRepo _repo;
   GetStorage getStorage;
  var myToken,appLang;
  bool loginStatus;

  bool privateReqComplete = false;

   List<SliderDataList> sliderList = [];
   List<CoursesDataList> coursesList = [];
   List<FeaturesDataList> featureList = [];
   List<CategoryDataList> categoriesList = [];
   List<LiveCoursesDataList> liveCoursesList = [];
   List<OurTeachersDataList> ourTeachersList = [];
   AnalysisResData analysisData = AnalysisResData();



  List<String> logoutErrorMessage = [];


  VideoPlayerController controller;
  Future<void> initializeVideoPlayerFuture ;
  var _dio;
  List<String> errorsMessage = [];

  //TODO Private Course
  String selectedTeacher ,selectedCourse,selectedSat,selectedSun,selectedMon,selectedTue,selectedWed,
      selectedThu,selectedFri;
  var teacherId,courseId,startDate,note,satTime,sunTime,monTime,tueTime,wedTime,thuTime,friTime;
  PrivateCourseReqResData privateCourseReqResData = PrivateCourseReqResData();
  PrivateCourseReq privateCourseReq ;
  List<TeachersCoursesDataList> teachersCoursesList = [];


  var placementCurrentView = LocalDataStrings.PlacementTestData;
  var qNum = 0;
  Map<int,String> selectedAnswers = new Map<int,String>();
  List<bool> answersResult = [];
  CarouselSliderController questionSliderCont = CarouselSliderController();
  Timer secTimer,minTimer;
  int examTimeMin,examTimeSec = 60;
  List<SubmitPlacementTestAnsReq> submitPlacementTestAnsReq = [];
  SubmitPlacementTestAnsResData submitPlacementTestAnsResData = SubmitPlacementTestAnsResData();
  GetPlacementTestKeyResData placementTestKeyResData = GetPlacementTestKeyResData();
  GetPlacementExamResData placementExamResData = GetPlacementExamResData();


  StudProfResData studProfResData = StudProfResData();

  @override
  void onInit() async{
    // TODO: implement onInit
    _repo = HomeRepo();
    getStorage = GetStorage();
    loginStatus = getStorage.read(LocalDataStrings.isLogged);
    print('$LOGD  LoginStatus:: ${loginStatus}');
    modalHudController.changeisLoading(true);
    update();
    if(loginStatus!=null){
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

    await prepareVideo();
    await checkToken(myToken);
    await fireMethods().whenComplete(() {
      controller.setLooping(false);
      // controller.dispose();
      controller.pause();
      update();
    });

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

  Future<bool> getMainProfData(token)async{
    StudProfRepo stuRepo = StudProfRepo();
    modalHudController.changeisLoading(true);
    update();
    var res = await stuRepo.mainProfile(token).then((value) {
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
          getMainProfData(token);
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
           // Get.offAllNamed(Home.Id);
            update();
          }
        }
      });
      update();

    }

  }

  Future<void> fireMethods()async{
    appLang = await getStorage.read(LocalDataStrings.appLanguage);
    if(appLang == null){
      appLang = 'ar';
      Get.updateLocale(Locale('ar'));
      update();
    }

  await  getSliderData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

   await getCoursesData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    // getFeaturesData().whenComplete(() {
    //   modalHudController.changeisLoading(false);
    //   update();
    // });

    // getCategoriesData().whenComplete(() {
    //   modalHudController.changeisLoading(false);
    //   update();
    // });

   await getLiveCoursesData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

  await  getOurTeachersData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    // await getAnalysisData().whenComplete(() {
    //   modalHudController.changeisLoading(false);
    //   update();
    // });
  }

  Future<bool> getSliderData()async{
    modalHudController.changeisLoading(true);
   var res = await _repo.slider(appLang.toString()).then((value) {
      SliderRes sliderRes = SliderRes.fromJson(value.data);
      if (sliderRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<SliderResData> sliderResData =
        List<SliderResData>.from(
            list.map((e) => SliderResData.fromJson(e)).toList());
        sliderList = sliderResData.map((e) => SliderDataList(data: e)).toList();
        update();
        print('$LOGD sliderList length ${sliderList.length}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getCoursesData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.courses(appLang.toString()).then((value) {
      CoursesRes coursesRes = CoursesRes.fromJson(value.data);
      if (coursesRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<CoursesResData> sliderResData =
        List<CoursesResData>.from(
            list.map((e) => CoursesResData.fromJson(e)).toList());
        coursesList = sliderResData.map((e) => CoursesDataList(data: e)).toList();
        update();
        print('$LOGD coursesList length ${coursesList.length}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getFeaturesData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.features(appLang.toString()).then((value) {
      FeaturesRes featuresRes = FeaturesRes.fromJson(value.data);
      if (featuresRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<FeaturesResData> featureResData =
        List<FeaturesResData>.from(
            list.map((e) => FeaturesResData.fromJson(e)).toList());
        featureList = featureResData.map((e) => FeaturesDataList(data: e)).toList();
        update();
        print('$LOGD featureList length ${featureList.length}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getCategoriesData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.categories(appLang.toString()).then((value) {
      CategoryRes categoryRes = CategoryRes.fromJson(value.data);
      if (categoryRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<CategoryResData> categoryResData =
        List<CategoryResData>.from(
            list.map((e) => CategoryResData.fromJson(e)).toList());
        categoriesList = categoryResData.map((e) => CategoryDataList(data: e)).toList();
        update();
        print('$LOGD categoriesList length ${categoriesList.length}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getLiveCoursesData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.liveCourses(appLang.toString()).then((value) {
      LiveCouresesRes liveCouresesRes = LiveCouresesRes.fromJson(value.data);
      if (liveCouresesRes.status){
        final result = value.data;
        Iterable list =result['data'];
        List<LiveCourseResData> liveCoursesListData =
        List<LiveCourseResData>.from(
            list.map((e) => LiveCourseResData.fromJson(e)).toList());
        liveCoursesList = liveCoursesListData.map((e) => LiveCoursesDataList(data: e)).toList();
        update();
        print('$LOGD liveCoursesList length ${liveCoursesList.length}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getOurTeachersData()async{
    modalHudController.changeisLoading(true);
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
    });

    return res;
  }

  Future<bool> getAnalysisData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.analysis().then((value) {
      AnalysisRes analysisRes = AnalysisRes.fromJson(value.data);
      if (analysisRes.status){
         analysisData = AnalysisResData.fromJson(analysisRes.data.toJson());
        update();
        print('$LOGD getAnalysis classes ${analysisData.classes}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  changeTeacher(teacherName,teacherKey)async{
    teachersCoursesList = [];
    selectedCourse = null;
    selectedTeacher = teacherName;
    teacherId = teacherKey;
    Get.back();
    await getTeacherCourses(teacherKey);
    update();
  }

  changeCourse(courseName,id)async{
    // selectedCourse = null;
   selectedCourse = courseName;
    // selectedCourse = teachersCoursesList.isEmpty ? 'Select ' : teachersCoursesList.firstWhere((element) => element.name == courseName);
    courseId = id;
    print('$LOGD changeCourse: ${this.courseId}');
    print('$LOGD changeCourse: $selectedCourse');
    update();
    Get.back();

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

  Future<String> preparePrivateCourseReq()async{
    privateCourseReq = PrivateCourseReq(teacherId: teacherId,courseId: courseId,startDate: startDate,note: note,
           sat: satTime,sun: sunTime,mon: monTime,tue: tueTime,wed: wedTime,thu: thuTime,fri: friTime);
    print('$LOGD preparePrivateCourseReq: ${jsonEncode(privateCourseReq)}');
    await sendPrivateReq(privateCourseReq, myToken, appLang);
  }

  Future<String> sendPrivateReq(req,token,appLang)async{
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
        privateReqComplete = true;
        update();
      }else{
        quizResultRes.massage.forEach((element) {
          errorsMessage.add(element);
          privateReqComplete = false;
          update();
        });
      }
    }).catchError((e){
      errorsMessage.add(e.toString());
      // PrivateCourseReqRes quizResultRes = e;
      update();
      print('$LOGD sendPrivateReq catchError ${e}');
     }).whenComplete(() {
      modalHudController.changeisLoading(false);
      clearPrivateCourseScreen();
      // Get..back();
      update();
     });
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

  clearPrivateCourseScreen(){
    selectedTeacher = null;
    selectedCourse = null;
    selectedSat = '';
    selectedSun = '';
    selectedMon = '';
    selectedTue = '';
    selectedWed = '';
    selectedThu = '';
    selectedFri = '';
    teacherId = null;
  courseId = null;
  startDate = '';
  note = '';
  satTime = '';
  sunTime = '';
  monTime = '';
  tueTime = '';
  wedTime = '';
  thuTime = '';
  friTime = '';
    // Get.back();
    update();
  }

  Future<bool> getPalcementKey(token,appLang)async{
    bool resValue;
    modalHudController.changeisLoading(true);
    placementExamResData = GetPlacementExamResData();
    placementCurrentView = LocalDataStrings.PlacementTestData;
    selectedAnswers.clear();
    answersResult.clear();
    update();
    var res = await _repo.getPlacementTestKey(token,appLang.toString()).then((value) {
      GetPlacementTestKeyRes placementTestKeyRes = GetPlacementTestKeyRes.fromJson(value.data);
      if (placementTestKeyRes.status){
        placementTestKeyResData = GetPlacementTestKeyResData.fromJson(placementTestKeyRes.data.toJson());
        resValue = true;
        update();
        getPlacementExamData(placementTestKeyResData.examKey, token, appLang);
        print('$LOGD getPalcementKey Exam Key:: ${placementTestKeyResData.examKey}');
        return true;
      }else{
        resValue = false;
        update();
        return false;
      }
    }).catchError((e){
      print('$LOGD getPalcementKey Error :: ${e}');
      resValue = false;
      modalHudController.changeisLoading(false);
      update();
    }).whenComplete(() {
      // modalHudController.changeisLoading(false);
      // update();
      return resValue;
    });
    return resValue;
  }

  Future<bool> getPlacementExamData(examKey,token,appLang)async{
    bool resValue;
    modalHudController.changeisLoading(true);
    examTimeMin = 0;
    examTimeSec = 60;
    placementQuesList.clear();
    submitPlacementTestAnsReq.clear();
    update();
    var res = await _repo.getPlacementExam(examKey,token,appLang.toString()).then((value) {
      GetPlacementExamRes placementExamRes = GetPlacementExamRes.fromJson(value.data);
      if (placementExamRes.status){
        placementExamResData = GetPlacementExamResData.fromJson(placementExamRes.data.toJson());

        examTimeMin = int.parse(placementExamResData.time);
       qNum = 0;
        placementExamResData.sections.forEach((element) {
          qNum = qNum + element.questions.length ;
        });
        resValue = true;
        update();
        print('$LOGD getPlacementExamData examTime:: ${examTimeMin}');
        print('$LOGD getPlacementExamData res:: ${jsonEncode(placementExamResData)}');
        return true;
      }else{
        resValue = false;
        update();
        return false;
      }
    }).catchError((e){
      print('$LOGD getPlacementExamData Error :: ${e}');
      resValue = false;
      update();
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
      return resValue;
    });
    return resValue;
  }

  changePlacementView(viewName){
  placementCurrentView = viewName;
  update();
  }

  changeSelectedValue(value,index){
    selectedAnswers[index] = value;
    update();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    const oneMin = const Duration(minutes: 1);

    secTimer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (examTimeSec == 0) {
            // timer.cancel();
            // update();
        } else {
            // examTimeMin--;
            examTimeSec--;
            update();
        }
      },
    );

    minTimer = new Timer.periodic(
      oneMin,
          (Timer timer) {
        if (examTimeMin == 0) {
          timer.cancel();
          update();
        } else {
          examTimeMin--;
          examTimeSec = 60;
          update();
        }
      },
    );

  }

  List<PlacementQuestions> placementQuesList = [];

  nextQuestion(secIndex,quesIndex,selectedAnsKey){
    print('$LOGD nextQues :secIndex: ${secIndex}  quesIndex: $quesIndex');
    placementQuesList.clear();
    PlacementQuestions placementQues =PlacementQuestions();

    placementQues = PlacementQuestions(
      question: placementExamResData.sections[secIndex].questions[quesIndex].key.toString(),
      answer: selectedAnsKey.toString(),
    );
    print('$LOGD nextQues :placementQues: ${jsonEncode(placementQues)}');

    placementQuesList.add(placementQues);
    submitPlacementTestAnsReq.insert(secIndex, SubmitPlacementTestAnsReq(
        section: placementExamResData.sections[secIndex].key.toString(),
        questions: placementQuesList
    ));
    // print('$LOGD nextQues :: ${jsonEncode(placementQuesList)}');

    if(secIndex+1 == qNum){
      placementCurrentView = LocalDataStrings.PlacementTestScore;
      SubmitAnsAllReq submitAnsAllReq = SubmitAnsAllReq(
        examKey: placementExamResData.key,
        result: json.encode(submitPlacementTestAnsReq),
      );
      print('$LOGD nextQues :LastQuestion: ${jsonEncode(submitAnsAllReq.toJson())}');
      submitAnswers(submitAnsAllReq, myToken, appLang);
      update();
    }else{
      questionSliderCont.nextPage();
      update();
    }
    update();
  }

  submitAnswers(req,token,appLang)async{
    errorsMessage.clear();
    modalHudController.changeisLoading(true);
    submitPlacementTestAnsResData = SubmitPlacementTestAnsResData();
    update();
    var res = await _repo.submitPlacementAnswers(req,token,appLang).then((value) {
      SubmitPlacementTestAnsRes quizResultRes = SubmitPlacementTestAnsRes.fromJson(value.data);
      if(quizResultRes.status){
        submitPlacementTestAnsResData = SubmitPlacementTestAnsResData.fromJson(quizResultRes.data.toJson());
        print('$LOGD submitPlacementTestAnsResData :: ${jsonEncode(submitPlacementTestAnsResData)}');
        update();
        // Get.back();
        // Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
        //     colorText: ConstStyles.WhiteColor,
        //     titleText: CustomText(txt: 'Successfully pass Placement Test ',
        //       txtAlign: TextAlign.center,));
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
      update();
      print('$LOGD submitPlacementTestAnsResData catchError ${e}');
    }).whenComplete(() {
      // checkAnswers.clear();
      selectedAnswers.clear();
      answersResult.clear();
      update();
      modalHudController.changeisLoading(false);
      update();
    });
  }
}