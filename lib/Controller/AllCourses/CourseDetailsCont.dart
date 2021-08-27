import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:open_file/open_file.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/Models/PlacementKey/GetPlacementExam/GetPlacementExamRes.dart';
import 'package:troom/Models/PlacementKey/GetPlacementExam/GetPlacementExamResData.dart';
import 'package:troom/Models/PlacementKey/GetPlacementKey/GetPlacementTestKeyResData.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitAnsAllReq.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsReq.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsRes.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsResData.dart';
import 'package:troom/Models/QuizChapter/QuizChapterQuestionList.dart';
import 'package:troom/Models/QuizChapter/QuizChapterRes.dart';
import 'package:troom/Models/QuizChapter/QuizChapterResData.dart';
import 'package:troom/Models/QuizLesson/QuizLessonQuestionsList.dart';
import 'package:troom/Models/QuizLesson/QuizLessonRes.dart';
import 'package:troom/Models/QuizLesson/QuizLessonResData.dart';
import 'package:troom/Models/QuizResult/QuizChapterResultReq.dart';
import 'package:troom/Models/QuizResult/QuizResultReq.dart';
import 'package:troom/Models/QuizResult/QuizResultRes.dart';
import 'package:troom/Models/QuizResult/QuizResultResData.dart';
import 'package:troom/Repo/HomeRepo.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/Courses/ChapterExam.dart';
import 'package:troom/View/Courses/CourseDetails.dart';
import 'package:troom/View/Courses/LessonExam.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Models/BuyCourse/BuyCourseRes.dart';
import 'package:troom/Models/CourseDetails/CourseDetailsRes.dart';
import 'package:troom/Models/CourseDetails/CourseDetailsResData.dart';
import 'package:troom/Models/LessonData/LessonDataRes.dart';
import 'package:troom/Models/LessonData/LessonDataResData.dart';
import 'package:troom/Repo/CourseDetailsRepo.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:permission_handler/permission_handler.dart';

class CourseDetailsCont extends GetxController {
  String LOGD = 'CourseDetailsCont-->';
  ModalHudCont modalHudController = Get.put(ModalHudCont());
  CourseDetailsRepo _repo;
  GetStorage getStorage;

  String showType = 'Overview';
  String token;

  var appLang;
  var courseKey;
  CourseDetailsResData courseDetailsResData = CourseDetailsResData();
  LessonDataResData lessonDataResData = LessonDataResData();
  List<LessonsList> lessonList = [];

  List<QuizLessonQuestionsList> questionsLessonList = [];
  Map<int, String> selectedAnswers;

  List<bool> answersResult;
  List<QuizChapterQuestionList> questionChapterList = [];

  List<String> errors = [];
  QuizResultResData quizResultResData = QuizResultResData();
  QuizResultReq quizResultReq;
  QuizChapterResultReq quizChapterResultReq;
  List<bool> checkAnswers;

  var vidV = 'Ready';

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  var placementCurrentView = LocalDataStrings.PlacementTestData;
  var qNum = 0;
  Map<int, String> placementSelectedAnswers = new Map<int, String>();
  List<bool> placementAnswersResult = [];
  CarouselSliderController questionSliderCont = CarouselSliderController();
  Timer secTimer, minTimer;
  int examTimeMin, examTimeSec = 60;
  List<SubmitPlacementTestAnsReq> submitPlacementTestAnsReq = [];
  SubmitPlacementTestAnsResData submitPlacementTestAnsResData =
      SubmitPlacementTestAnsResData();
  List<PlacementQuestions> placementQuesList = [];
  GetPlacementTestKeyResData placementTestKeyResData =
      GetPlacementTestKeyResData();
  GetPlacementExamResData placementExamResData = GetPlacementExamResData();

  // VideoPlayerController controller;
  // Future<void> initializeVideoPlayerFuture ;
  // late Map<int,bool> checkAnswers = Map<int,bool>();

  List<myItem> myExpandedItem = [];

  CourseDetailsCont(this.courseKey) {
    _repo = CourseDetailsRepo();
    getStorage = GetStorage();
    token = getStorage.read(LocalDataStrings.myToken);
    appLang = getStorage.read(LocalDataStrings.appLanguage);
    //TODO get course details
    selectedAnswers = new Map<int, String>();
    placementSelectedAnswers = new Map<int, String>();
    placementAnswersResult = [];
    answersResult = [];
    checkAnswers = [];
    update();
  }

  List<LessonsList> getLessonList(index) {
    final result = jsonEncode(courseDetailsResData.chapters[index].lessonsList);
    // print('$LOGD getLessonList  course key ${courseDetailsResData.key.toString()}');
    Iterable l = json.decode(result);
    List<LessonsList> lessonList =
        List<LessonsList>.from(l.map((model) => LessonsList.fromJson(model)))
            .toList();
    return lessonList;
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    print('$LOGD Ready...');
    if (appLang == null) {
      appLang = 'ar';
      update();
    }
    if (courseKey != null) {
      modalHudController.changeisLoading(true);
      await getCourseDetailsData(courseKey.toString(), token.toString());
      update();
    }
    super.onReady();
  }

  changeShowType(type) {
    showType = type;
    update();
  }

  Future<bool> getCourseDetailsData(courseKey, token) async {
    // modalHudController.changeisLoading(true);
    courseDetailsResData = CourseDetailsResData();
    myExpandedItem.clear();
    update();
    var res = await _repo
        .courseDetails(courseKey, token, appLang.toString())
        .then((value) {
      CourseDetailsRes courseDetailsRes = CourseDetailsRes.fromJson(value.data);
      if (courseDetailsRes.status) {
        courseDetailsResData =
            CourseDetailsResData.fromJson(courseDetailsRes.data.toJson());
        courseDetailsResData.chapters.forEach((element) {
          myExpandedItem
              .add(myItem(header: element.name, body: element.lessonsList));
        });
        update();
        print(
            '$LOGD getCourseDetailsData  Name ${jsonEncode(courseDetailsResData)}');
        return true;
      } else {
        return false;
      }
    }).whenComplete(() async {
      if (courseDetailsResData.currentLessonKey != null) {
        print('$LOGD ---> ${courseDetailsResData.currentLessonKey}');
        if (courseDetailsResData.currentLessonKey != null) {
          await getLessonData(courseDetailsResData.currentLessonKey, token);
        }
        modalHudController.changeisLoading(false);
        update();
      }
      update();
    });

    return res;
  }

  Future<bool> getLessonData(currentLessonKey, token) async {
    modalHudController.changeisLoading(true);
    // getStorage!.remove('CurrentLessonKey');

    print("this is the currentLessonKey $currentLessonKey");
    update();
    lessonDataResData = LessonDataResData();
    var res = await _repo
        .lessonData(currentLessonKey, token, appLang.toString())
        .then((value) {
      LessonDataRes lessonDataRes = LessonDataRes.fromJson(value.data);

      if (lessonDataRes.status) {
        print("###################${value.data}");

        lessonDataResData =
            LessonDataResData.fromJson(lessonDataRes.data.toJson());

        print("###################${lessonDataResData.video}");

        prepareVideo(lessonDataResData.video);

        update();

        if (lessonDataResData.lessonClosed) {
          Get.snackbar('', '',
              backgroundColor: ConstStyles.DarkColor,
              colorText: ConstStyles.WhiteColor,
              titleText: CustomText(
                txt: 'YouShouldPassTheLessonExamFirst'.tr,
                txtAlign: TextAlign.center,
              ));
        }

        return true;
      } else {
        return false;
      }
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    print("##########@@@@@@@@@@@###############@@@@@@@@@#######@@@@@@@####@#@#@##$res");
    return res;
  }

  Future<String> getPauPalLink(courseKey, token) async {
    modalHudController.changeisLoading(true);
    update();
    BuyCourseRes courseDetailsRes;
    var res = await _repo.buyCourse(courseKey, token).then((value) {
      courseDetailsRes = BuyCourseRes.fromJson(value.data);
      if (courseDetailsRes.status) {
        update();
        print('$LOGD getPauPalLink   ${courseDetailsRes.data.link}');
        return courseDetailsRes.data.link;
      } else {
        return null;
      }
    }).whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
    return courseDetailsRes.data.link.toString();
  }

  Future<void> getCourseQuizLesson(lessonKey, token) async {
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.courseQuizLesson(lessonKey, token).then((value) {
      QuizLessonRes quizLessonRes = QuizLessonRes.fromJson(value.data);
      if (quizLessonRes.status) {
        final result = value.data;
        Iterable list = result['data'];
        List<QuizLessonResData> quizLessonResData =
            List<QuizLessonResData>.from(
                list.map((e) => QuizLessonResData.fromJson(e)).toList());
        questionsLessonList = quizLessonResData
            .map((e) => QuizLessonQuestionsList(data: e))
            .toList();
        update();
        print(
            '$LOGD getCourseQuizLesson resData:: ${jsonEncode(quizLessonResData)}');
        // print('$LOGD getCourseQuizLesson Q1:: ${questionsList[0].question}');
      }
    }).whenComplete(() {
      //TODO if questionList > 0 then open exam view
      modalHudController.changeisLoading(false);
      update();
      if (questionsLessonList.length > 0) {
        Get.to(() => LessonExam(lessonDataResData.name, questionsLessonList));
      }
    });
  }

  Future<void> getCourseQuizChapter(chapterKey, token, chapterName) async {
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.courseQuizChapter(chapterKey, token).then((value) {
      QuizChapterRes quizLessonRes = QuizChapterRes.fromJson(value.data);
      if (quizLessonRes.status) {
        final result = value.data;
        Iterable list = result['data'];
        List<QuizChapterResData> quizLessonResData =
            List<QuizChapterResData>.from(
                list.map((e) => QuizChapterResData.fromJson(e)).toList());
        questionChapterList = quizLessonResData
            .map((e) => QuizChapterQuestionList(data: e))
            .toList();
        update();
        print(
            '$LOGD getCourseQuizLesson resData:: ${jsonEncode(quizLessonResData)}');
        print(
            '$LOGD questionChapterList length:: ${questionChapterList.length}');
        // print('$LOGD getCourseQuizLesson Q1:: ${questionsList[0].question}');
      }
    }).whenComplete(() {
      //TODO if questionList > 0 then open exam view
      modalHudController.changeisLoading(false);
      update();
      if (questionChapterList.length > 0) {
        Get.to(() => ChapterExam(chapterName, questionChapterList, chapterKey));
      }
    });
  }

  changeSelectedValue(value, index) {
    selectedAnswers[index] = value;
    update();
  }

  submitAnswers(lessonKey) {
    for (int i = 0; i < questionsLessonList.length; i++) {
      if (answersResult[i]) {
        //TODO Sent True to Result Api
        checkAnswers.insert(i, true);
      } else {
        //TODO show wrong Answer
        checkAnswers.insert(i, false);
      }
    }
    update();

    if (checkAnswers.length >= questionsLessonList.length) {
      if (checkAnswers.contains(false)) {
        quizResultReq =
            QuizResultReq(lesson_key: lessonKey, result: 0.toString());
        print('$LOGD SubmitAnswer Req False=== ${jsonEncode(quizResultReq)}');
        sendQuizResult(quizResultReq);
      } else {
        quizResultReq =
            QuizResultReq(lesson_key: lessonKey, result: 1.toString());
        print('$LOGD SubmitAnswer Req True=== ${jsonEncode(quizResultReq)}');
        sendQuizResult(quizResultReq);
      }
    }
  }

  submitChapterAnswers(chapterKey) {
    for (int i = 0; i < questionChapterList.length; i++) {
      if (answersResult[i]) {
        //TODO Sent True to Result Api
        checkAnswers.insert(i, true);
      } else {
        //TODO show wrong Answer
        checkAnswers.insert(i, false);
      }
    }
    update();

    if (checkAnswers.length >= questionChapterList.length) {
      if (checkAnswers.contains(false)) {
        quizChapterResultReq =
            QuizChapterResultReq(chapter_key: chapterKey, result: 0.toString());
        print(
            '$LOGD submitChapterAnswers Req False=== ${jsonEncode(quizChapterResultReq)}');
        // Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
        //     colorText: ConstStyles.WhiteColor,
        //     titleText: CustomText(txt: 'FailedPassChapterExam'.tr,
        //       txtAlign: TextAlign.center,));
        sendChapterQuizResult(quizChapterResultReq);
      } else {
        quizChapterResultReq =
            QuizChapterResultReq(chapter_key: chapterKey, result: 1.toString());
        print(
            '$LOGD submitChapterAnswers Req True=== ${jsonEncode(quizChapterResultReq)}');
        // Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
        //     colorText: ConstStyles.WhiteColor,
        //     titleText: CustomText(txt: 'SuccessfullyPassChapterExam'.tr,
        //       txtAlign: TextAlign.center,));
        sendChapterQuizResult(quizChapterResultReq);
      }
    }
  }

  sendQuizResult(QuizResultReq quizReq) async {
    errors.clear();
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.quizResult(quizReq, token).then((value) {
      QuizResultRes quizResultRes = QuizResultRes.fromJson(value.data);
      if (quizResultRes.status) {
        quizResultResData =
            QuizResultResData.fromJson(quizResultRes.data.toJson());
        print('$LOGD sendQuizResult Res ${quizResultResData.pass}');
        update();
        Get.back();
        if (quizResultResData.pass == '0') {
          Get.snackbar('', '',
              backgroundColor: ConstStyles.DarkColor,
              colorText: ConstStyles.WhiteColor,
              titleText: CustomText(
                txt: 'FailedToPassLessonExam'.tr,
                txtAlign: TextAlign.center,
              ));
        } else {
          Get.snackbar('', '',
              backgroundColor: ConstStyles.DarkColor,
              colorText: ConstStyles.WhiteColor,
              titleText: CustomText(
                txt: 'SuccessfullyPassExam'.tr,
                txtAlign: TextAlign.center,
              ));
        }
        update();
        getLessonData(quizResultResData.nextLesson, token);
      } else {
        quizResultRes.massage.forEach((element) {
          errors.add(element);
          update();
        });
        Get.snackbar('', '',
            backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(
              txt: errors[0],
              txtAlign: TextAlign.center,
            ));
      }
    }).catchError((e) {
      errors.add(e.toString());
      update();
      print('$LOGD sendQuizResult catchError ${e}');
    }).whenComplete(() {
      checkAnswers.clear();
      selectedAnswers.clear();
      answersResult.clear();
      update();
      modalHudController.changeisLoading(false);
      update();
    });
  }

  sendChapterQuizResult(QuizChapterResultReq quizReq) async {
    errors.clear();
    modalHudController.changeisLoading(true);
    update();
    var res = await _repo.quizResult(quizReq, token).then((value) {
      QuizResultRes quizResultRes = QuizResultRes.fromJson(value.data);
      if (quizResultRes.status) {
        quizResultResData =
            QuizResultResData.fromJson(quizResultRes.data.toJson());
        print('$LOGD sendChapterQuizResult Res ${quizResultResData.pass}');
        update();
        Get.back();
        if (quizResultResData.pass == '0') {
          Get.snackbar('', '',
              backgroundColor: ConstStyles.DarkColor,
              colorText: ConstStyles.WhiteColor,
              titleText: CustomText(
                txt: 'FailedToPassLessonExam'.tr,
                txtAlign: TextAlign.center,
              ));
        } else {
          Get.snackbar('', '',
              backgroundColor: ConstStyles.DarkColor,
              colorText: ConstStyles.WhiteColor,
              titleText: CustomText(
                txt: 'SuccessfullyPassExam'.tr,
                txtAlign: TextAlign.center,
              ));
        }
        update();
        // getLessonData(quizResultResData.nextLesson, token);
      } else {
        quizResultRes.massage.forEach((element) {
          errors.add(element);
          update();
        });
        // Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
        //     colorText: ConstStyles.WhiteColor,
        //     titleText: CustomText(txt: errors[0],
        //       txtAlign: TextAlign.center,));
      }
    }).catchError((e) {
      errors.add(e.toString());
      update();
      print('$LOGD sendChapterQuizResult catchError ${e}');
    }).whenComplete(() {
      checkAnswers.clear();
      selectedAnswers.clear();
      answersResult.clear();
      update();
      modalHudController.changeisLoading(false);
      update();
    });
  }

  // playVideo(){
  //   controller.play();
  //   update();
  // }
  //
  // pauseVideo(){
  //   controller.pause();
  //   update();
  // }
  //
  // stopVideo(){
  //   controller.pause();
  //   controller.seekTo(Duration.zero);
  //   update();
  // }
  /*
  prepareVideo(url){
    print('$LOGD PrepareVideo URL : ${EndPoints.VideoUrl}$url');
    controller = VideoPlayerController.network(
        "${EndPoints.VideoUrl}$url",
        videoPlayerOptions: VideoPlayerOptions(
          mixWithOthers: true,
        )
    );
    initializeVideoPlayerFuture = controller.initialize();
    controller.addListener(() {
      if (!controller.value.isPlaying ){
        if(controller.value.duration.inSeconds ==controller.value.position.inSeconds){
          print('$LOGD ------> video Ended ${controller.value.isPlaying.toString()}');
          update();
        }
      }
    });
    update();
  }
*/

  prepareVideo(url) {
    // print('$LOGD PrepareVideo URL : ${EndPoints.VideoUrl}$url');

    print("@@@@@@@@@@@@@@@@@@@@ call Video player");

    if(videoPlayerController != null){
      videoPlayerController.pause();
      videoPlayerController.dispose();
    }

    videoPlayerController = VideoPlayerController.network(
      "${EndPoints.VideoUrl}$url",
      videoPlayerOptions: VideoPlayerOptions(
        mixWithOthers: true,
      ),
    );
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 16 / 9,
        autoInitialize: true,
        errorBuilder: (context, errorMessage) {
          return Center(
            child: CustomText(
              txt: errorMessage,
              txtColor: ConstStyles.DarkColor,
            ),
          );
        });

    update();
  }

  Future<bool> downloadMaterial(url) async {
    print("URL of video 3333333333# $url");
    modalHudController.changeisLoading(true);
    update();
    await getPermission();
    Dio dio = Dio();
    var path = '/storage/emulated/0/Download';
    // await getExternalStorageDirectory().then((value) {
    //   path = value!.absolute.path;
    //   print('$LOGD pathvalue:: ${path}');
    // });
    // String path2 = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    print('$LOGD pathvalue2:: ${path}');

    try {
      // var response = await dio.get(
      //   EndPoints.VideoUrl + url,
      //   onReceiveProgress: showProgress,
      //   options: Options(
      //       responseType: ResponseType.bytes,
      //       followRedirects: false,
      //       validateStatus: (status) {
      //         return status < 500;
      //       }),
      // );
      // print("#####${response.headers}");

      String filePath = path +"/${lessonDataResData.name}${Random().nextInt(10)}.pdf'";
      if(File(filePath).existsSync()){
        File(filePath).deleteSync();
      }
      Dio dio = new Dio();
      var response = await dio.download(EndPoints.VideoUrl + url, filePath,onReceiveProgress:(_c,_t){
        print(_c/_t*100);
      },);
      final message = await OpenFile.open(filePath);



      // File file = File(path +"/${lessonDataResData.name}${Random().nextInt(100)}.pdf'");
      // var raf = file.openSync(mode: FileMode.write);
      // raf.writeFromSync(response.data);
      // await raf.close();
      modalHudController.changeisLoading(false);
      update();

      return true;
    } catch (e) {
      print('$LOGD Download Error:: ${e.toString()}');
      modalHudController.changeisLoading(false);
      update();
      return false;
    }
  }

  showProgress(received, total) {
    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + '%');
    }
  }

  getPermission() async {
    await Permission.storage.request();
    print('$LOGD getPermission ${Permission.storage.isGranted.toString()}');
    update();
  }

  Future<bool> getPlacementExamData(examKey, token, appLang) async {
    bool resValue;
    modalHudController.changeisLoading(true);
    examTimeMin = 0;
    examTimeSec = 60;
    placementQuesList.clear();
    submitPlacementTestAnsReq.clear();
    update();
    HomeRepo homeRepo = HomeRepo();
    var res = await homeRepo
        .getPlacementExam(examKey, token, appLang.toString())
        .then((value) {
      GetPlacementExamRes placementExamRes =
          GetPlacementExamRes.fromJson(value.data);
      if (placementExamRes.status) {
        placementExamResData =
            GetPlacementExamResData.fromJson(placementExamRes.data.toJson());

        examTimeMin = int.parse(placementExamResData.time);
        qNum = 0;
        placementExamResData.sections.forEach((element) {
          qNum = qNum + element.questions.length;
        });
        resValue = true;
        update();
        print('$LOGD getPlacementExamData examTime:: ${examTimeMin}');
        print(
            '$LOGD getPlacementExamData res:: ${jsonEncode(placementExamResData)}');
        return true;
      } else {
        resValue = false;
        update();
        return false;
      }
    }).catchError((e) {
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

  changePlacementView(viewName) {
    placementCurrentView = viewName;
    update();
  }

  nextQuestion(secIndex, quesIndex, selectedAnsKey) {
    print('$LOGD nextQues :secIndex: ${secIndex}  quesIndex: $quesIndex');
    placementQuesList.clear();
    PlacementQuestions placementQues = PlacementQuestions();

    placementQues = PlacementQuestions(
      question: placementExamResData.sections[secIndex].questions[quesIndex].key
          .toString(),
      answer: selectedAnsKey.toString(),
    );

    placementQuesList.add(placementQues);
    submitPlacementTestAnsReq.insert(
        secIndex,
        SubmitPlacementTestAnsReq(
            section: placementExamResData.sections[secIndex].key.toString(),
            questions: placementQuesList));
    // print('$LOGD nextQues :: ${jsonEncode(placementQuesList)}');

    if (secIndex + 1 == qNum) {
      placementCurrentView = LocalDataStrings.PlacementTestScore;
      SubmitAnsAllReq submitAnsAllReq = SubmitAnsAllReq(
        examKey: placementExamResData.key,
        result: json.encode(submitPlacementTestAnsReq),
      );
      print(
          '$LOGD nextQues :LastQuestion: ${jsonEncode(submitAnsAllReq.toJson())}');
      submitPlacementAnswers(submitAnsAllReq, token, appLang);
      update();
    } else {
      questionSliderCont.nextPage();
      update();
    }
    update();
  }

  submitPlacementAnswers(req, token, appLang) async {
    errors.clear();
    modalHudController.changeisLoading(true);
    submitPlacementTestAnsResData = SubmitPlacementTestAnsResData();
    update();
    HomeRepo homeRepo = HomeRepo();
    var res = await homeRepo
        .submitPlacementAnswers(req, token, appLang)
        .then((value) {
      SubmitPlacementTestAnsRes quizResultRes =
          SubmitPlacementTestAnsRes.fromJson(value.data);
      if (quizResultRes.status) {
        submitPlacementTestAnsResData =
            SubmitPlacementTestAnsResData.fromJson(quizResultRes.data.toJson());
        print(
            '$LOGD submitPlacementTestAnsResData :: ${jsonEncode(submitPlacementTestAnsResData)}');
        update();
        // Get.back();
        // Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
        //     colorText: ConstStyles.WhiteColor,
        //     titleText: CustomText(txt: 'Successfully pass Placement Test ',
        //       txtAlign: TextAlign.center,));
        update();
      } else {
        quizResultRes.massage.forEach((element) {
          errors.add(element);
          update();
        });
        Get.snackbar('', '',
            backgroundColor: ConstStyles.DarkColor,
            colorText: ConstStyles.WhiteColor,
            titleText: CustomText(
              txt: errors[0],
              txtAlign: TextAlign.center,
            ));
      }
    }).catchError((e) {
      errors.add(e.toString());
      update();
      print('$LOGD submitPlacementTestAnsResData catchError ${e}');
    }).whenComplete(() {
      // checkAnswers.clear();
      placementSelectedAnswers.clear();
      placementAnswersResult.clear();
      update();
      modalHudController.changeisLoading(false);
      update();
    });
  }

  clearPlacementData() {
    placementCurrentView = LocalDataStrings.PlacementTestData;
    placementAnswersResult.clear();
    placementSelectedAnswers.clear();
    qNum = 0;
    examTimeMin = null;
    examTimeSec = 60;
    Get.back();
    update();
  }

  changeSelectedPlacementValue(value, index) {
    placementSelectedAnswers[index] = value;
    update();
  }

  changeExpandedView(index) {
    myExpandedItem[index].isExpanded = !myExpandedItem[index].isExpanded;
    update();
  }

  @override
  void onClose() {
    if (chewieController != null) {
      chewieController.pause();
      chewieController.dispose();
      videoPlayerController.dispose();
    }

    // Get.back();
    checkAnswers.clear();
    courseKey = null;
    courseDetailsResData = CourseDetailsResData();
    // Get.back();
    //   Get.forceAppUpdate();
    update();
    print('$LOGD CLOSED-------');
    super.onClose();
  }
}
