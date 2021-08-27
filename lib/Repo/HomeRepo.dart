import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:troom/Models/Analysis/AnalysisRes.dart';
import 'package:troom/Models/Category/CategoryRes.dart';
import 'package:troom/Models/Courses/CoursesRes.dart';
import 'package:troom/Models/Features/FeaturesRes.dart';
import 'package:troom/Models/LiveCourses/LiveCoursesRes.dart';
import 'package:troom/Models/OurTeachers/OurTeacherRes.dart';
import 'package:troom/Models/Slider/SliderRes.dart';
import 'package:troom/Util/EndPoints.dart';

class HomeRepo {
  static const LOGD = 'HomeRepo-->';
  var _dio;

  HomeRepo() {
    _dio = Dio();
  }

  Future<dynamic> slider(appLang) async {
    var url = EndPoints.Slider + '?lang=' + appLang;
    print('$LOGD slider URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD response  ${response}');
      return response;
    } on DioError catch (e) {
      return response;
    }
  }

  Future<dynamic> courses(appLang) async {
    var url = EndPoints.Courses + '?lang=' + appLang;
    print('$LOGD courses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD courses response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> features(appLang) async{
    var url = EndPoints.Features + '?lang=' + appLang;
    print('$LOGD features URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD features response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> categories(appLang) async{
    var url = EndPoints.Category + '?lang=' + appLang;
    print('$LOGD categories URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD categories response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> liveCourses(appLang) async{
    var url = EndPoints.LiveCourses + '?lang=' + appLang;
    print('$LOGD liveCourses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD liveCourses response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> ourTeachers() async{
    var url = EndPoints.OurTeachers;
    print('$LOGD ourTeachers URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD ourTeachers response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> teacherCourses(teacherKey,token,appLang) async{
    var url = EndPoints.TeachersCourses + '/' + teacherKey.toString() + '?token=' + token.toString() + '&lang=' + appLang;
    print('$LOGD teacherCourses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD teacherCourses response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD teacherCourses response  ${e.toString()}');
      return e.response;
    }
  }

  Future<dynamic> sendPrivateReq(msgReq,token,appLang)async{
    var response;
    print('$LOGD sendPrivateReq req: ${jsonEncode(msgReq)}');
    print('$LOGD sendPrivateReq Url: ${EndPoints.SendPrivateReq + '?token=' + token + '&lang=' + appLang}');

    print("####################$msgReq");
    print("####################$token");

    try{
      var response = await this._dio.post(
        EndPoints.SendPrivateReq + '?token=' + token + '&lang=' + appLang,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(msgReq),
      );


      print('$LOGD sendPrivateReq response : ${response}');
      return response;
    }on DioError catch(e){
      print('$LOGD sendPrivateReq error : ${response}');
      return e.response;
    }
  }


  Future<dynamic> analysis() async{
    var url = EndPoints.Analysis;
    print('$LOGD analysis URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD analysis response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> logout(token)async{
    var response;
    try{
      response = await this._dio.post(
        EndPoints.Logout,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD logout response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD logout error : ${e.response.toString()}');
      return e.response;
    }
  }

  Future<dynamic> getPlacementTestKey(token,appLang)async{
    var response;
    var url = EndPoints.PlacementTestKey + '?token=' + token + '&lang=' + appLang;
    print('$LOGD getPlacementTestKey Url $url');
    try{
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD getPlacementTestKey response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD getPlacementTestKey error : ${e.response.toString()}');
      return e.response;
    }
  }

  Future<dynamic> getPlacementExam(examKey,token,appLang)async{
    var response;
    var url = EndPoints.PlacementExamData + '/'+ examKey.toString() +
        '?token=' + token + '&lang=' + appLang;
    print('$LOGD getPlacementExam Url $url');
    try{
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD getPlacementExam response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD getPlacementExam error : ${e.toString()}');
      return e.response;
    }
  }

  Future<dynamic> submitPlacementAnswers(req,token,appLang)async{
    var response;
    var url = EndPoints.SubmitPlacementExamAnswers + '?token=' + token + '&lang=' + appLang ;
    print('$LOGD submitPlacementAnswers URL: ${url}');
    print('$LOGD submitPlacementAnswers REQ: ${json.encode(req)}');

    try{
      response = await this._dio.post(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(req),
      );
      print('$LOGD submitPlacementAnswers response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD submitPlacementAnswers error : ${e.response.toString()}');
      return e.response;
    }
  }
}