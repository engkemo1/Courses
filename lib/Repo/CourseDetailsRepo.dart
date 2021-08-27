import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:troom/Models/BuyCourse/BuyCourseRes.dart';
import 'package:troom/Models/CourseDetails/CourseDetailsRes.dart';
import 'package:troom/Models/LessonData/LessonDataRes.dart';
import 'package:troom/Models/LiveCourseDetails/LiveCourseDetailsRes.dart';
import 'package:troom/Models/QuizChapter/QuizChapterRes.dart';
import 'package:troom/Models/QuizLesson/QuizLessonRes.dart';
import 'package:troom/Util/EndPoints.dart';

class CourseDetailsRepo{

  static const LOGD = 'CourseDetailsRepo-->';
  var _dio;

  CourseDetailsRepo() {
    _dio = Dio();
  }

  Future<dynamic> courseDetails(courseKey,token,appLang) async{

    var url = EndPoints.CourseDetails + '/' + courseKey.toString() + '?token=' + token + '&lang=' + appLang;
    print('$LOGD courseDetails URL $url');
    var response;
    CourseDetailsRes courseDetailsRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD courseDetails response  ${response}');
      courseDetailsRes = CourseDetailsRes.fromJson(response.data);
      print('$LOGD courseDetails response details  ${courseDetailsRes}');
      return response;
    } on DioError catch (e) {
      courseDetailsRes = CourseDetailsRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> lessonData(currentLessonKey,token,appLang) async{
    var url = EndPoints.LessonData + '/' + currentLessonKey.toString() +'?lang='+appLang + '&token=' + token.toString();
    print('$LOGD lessonData URL $url');
    var response;
    LessonDataRes lessonDataRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD lessonData response  ${response}');
      lessonDataRes = LessonDataRes.fromJson(response.data);
      print('$LOGD lessonData response details  ${lessonDataRes}');
      return response;
    } on DioError catch (e) {
      print('$LOGD lessonData response Error  ${e.response.toString()}');
      return e.response;
    }
  }

  Future<dynamic> buyCourse(courseKey,token)async{
    var url = EndPoints.BuyCourse + '/' + courseKey.toString() + '?token=' + token;
    print('$LOGD buyCourse URL $url');
    var response;
    BuyCourseRes buyCourseRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD buyCourse response  ${response}');
      buyCourseRes = BuyCourseRes.fromJson(response.data);
      print('$LOGD buyCourse response details  ${buyCourseRes}');
      return response;
    } on DioError catch (e) {
      buyCourseRes = BuyCourseRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> liveCourseDetails(courseKey,token,appLang) async{
    var url = EndPoints.LiveCourseDetails + '/' + courseKey.toString() + '?token=' + token + '&lang=' + appLang;
    print('$LOGD liveCourseDetails URL $url');
    var response;
    LiveCourseDetailsRes courseDetailsRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD liveCourseDetails response  ${response}');
      courseDetailsRes = LiveCourseDetailsRes.fromJson(response.data);
      print('$LOGD liveCourseDetails response details  ${courseDetailsRes}');
      return response;
    } on DioError catch (e) {
      courseDetailsRes = LiveCourseDetailsRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> courseQuizLesson(lessonKey,token)async{
    var url = EndPoints.QuizLesson + '/' + lessonKey.toString() + '?token=' + token;
    print('$LOGD courseQuizLesson URL $url');
    var response;
    QuizLessonRes quizLessonRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD courseQuizLesson response  ${response}');
      return response;
    } on DioError catch (e) {
      quizLessonRes = QuizLessonRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> courseQuizChapter(chapterKey,token)async{
    var url = EndPoints.QuizChapter + '/' + chapterKey.toString() + '?token=' + token;
    print('$LOGD courseQuizChapter URL $url');
    var response;
    QuizChapterRes quizLessonRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD courseQuizChapter response  ${response}');
      quizLessonRes = QuizChapterRes.fromJson(response.data);
      print('$LOGD courseQuizChapter response details  ${quizLessonRes}');
      return response;
    } on DioError catch (e) {
      quizLessonRes = QuizChapterRes.fromJson(response.data);
      return e.response;
    }
  }


  Future<dynamic> quizResult(quizReq,token)async{
    var response;
    print('$LOGD quizResult req: ${jsonEncode(quizReq)}');

    try{
      response = await this._dio.post(
        EndPoints.QuizResult + token,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(quizReq),
      );
      print('$LOGD quizResult response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD quizResult error : ${e.response.toString()}');
      return e.response;
    }
  }

}