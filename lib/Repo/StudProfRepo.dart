import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/StudProfRes.dart';
import 'package:troom/Util/EndPoints.dart';

class StudProfRepo {
  static const LOGD = 'StudProfRepo-->';
  var _dio;

  StudProfRepo() {
    _dio = Dio();
  }

  Future<dynamic> mainProfile(token) async{

    var url = EndPoints.MainProfile  + '?token=' + token;
    print('$LOGD mainProfile URL $url');
    var response;
    StudProfRes studProfRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD mainProfile response  ${response}');
      studProfRes = StudProfRes.fromJson(response.data);
      print('$LOGD mainProfile response name  ${studProfRes.data.name}');
      return response;
    } on DioError catch (e) {
      studProfRes = StudProfRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> editProfile(profReq,token)async{
    var response;
    print('$LOGD editProfile req: ${jsonEncode(profReq)}');
    print('$LOGD editProfile Url: ${EndPoints.EditStudProf + '?token=' + token.toString()}');

    try{
      response = await this._dio.post(
        EndPoints.EditStudProf + '?token=' + token.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(profReq),
      );
      print('$LOGD editProfile : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD editProfile : ${e.response.toString()}');
      return e.response;
    }
  }

  Future<dynamic> myCourses(token,appLang)async{
    var url = EndPoints.MyCourses + token.toString() + '&lang='+appLang;
    print('$LOGD myCourses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD myCourses response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD myCourses response Error ${e.response}');
      return e.response;
    }
  }

  Future<dynamic> myClasses(token,appLang)async{
    var url = EndPoints.MyClasses + token.toString() + '&lang=' + appLang;
    print('$LOGD myClasses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD myClasses response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD myClasses response Error ${e.response}');
      return e.response;
    }
  }

  Future<dynamic> myPrivateClasses(token,appLang)async{
    var url = EndPoints.MyPrivateClasses + token.toString() + '&lang=' + appLang;
    print('$LOGD myPrivateClasses URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD myPrivateClasses response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD myPrivateClasses response Error ${e.response}');
      return e.response;
    }
  }


  Future<dynamic> showMyClassLessons(classKey,token,appLang)async{
    var url = EndPoints.ShowMyClassLesson + '/' + classKey.toString() + '?lang=' +
        appLang + '&token=' + token.toString();
    print('$LOGD showMyClassLessons URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD showMyClassLessons response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD showMyClassLessons response Error ${e.response}');
      return e.response;
    }
  }

  Future<dynamic> showMyPrivateClassLessons(classKey,token,appLang)async{
    var url = EndPoints.ShowMyPrivateClassLesson + '/' + classKey.toString() + '?lang=' +
        appLang + '&token=' + token.toString();
    print('$LOGD showMyPrivateClassLessons URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD showMyPrivateClassLessons response  ${response}');
      return response;
    } on DioError catch (e) {
      print('$LOGD showMyPrivateClassLessons response Error ${e.response}');
      return e.response;
    }
  }


}