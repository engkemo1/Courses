import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:troom/Models/Auth/Login/LoginRes.dart';
import 'package:troom/Util/EndPoints.dart';

class AuthRepo{
  static const LOGD = 'AuthRepo-->';
  var _dio;

  AuthRepo() {
    _dio = Dio();
  }

  Future<dynamic> register(registerReq)async{
    var response;
    print('$LOGD register req: ${jsonEncode(registerReq)}');

    try{
      response = await this._dio.post(
        EndPoints.Register,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(registerReq),
      );
      print('$LOGD register : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD register : ${e.response.toString()}');
      return e.response;
    }
  }

  Future<dynamic> checkVerificationCode(verificationCode,userKey) async{
    var response;

    print('$LOGD checkVerificationCode Code: ${jsonEncode(verificationCode)} -----> ${userKey}');
    print('$LOGD checkVerificationCode Url: ${EndPoints.CheckVerificationCode + '/' +userKey.toString()}');
    // VerificationRes verificationRes;
    try{
      response = await this._dio.post(
        EndPoints.CheckVerificationCode + '/' +userKey.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(verificationCode),
      );

      print('$LOGD checkVerificationCode : ${response}');
      return response;
    }on DioError catch(e){

      print('$LOGD checkVerificationCode : ${jsonEncode(e.response)}');

      return response;
    }
  }

  Future<dynamic> login(loginReq)async{
    var response;
    print('$LOGD login req: ${jsonEncode(loginReq)}');

    try{
      response = await this._dio.post(
        EndPoints.Login,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(loginReq),
      );
      print('$LOGD login response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      LoginRes loginResFalse = LoginRes.fromJson(e.response.data);
      print('$LOGD login error : ${jsonEncode(loginResFalse)}');
      print('$LOGD login error 2 : ${e.response}');
      // loginResFalse.toJson();
      return e.response;
    }
  }

  Future<dynamic> resendCode(userKey)async{
    var response;
    print('$LOGD resendCode userKey: $userKey}');
    print('$LOGD resendCode URL: ${EndPoints.ResendVerificationCode}');
    try{
      response = await this._dio.post(
        EndPoints.ResendVerificationCode + '/' + userKey.toString(),
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD resendCode response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD resendCode error : ${e.response.toString()}');
      return e.response;
    }
  }
}