import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:troom/Models/ContactUs/ContactUsData/ContactUsRes.dart';
import 'package:troom/Util/EndPoints.dart';

class ContactUsRepo {
  static const LOGD = 'ContactUsRepo-->';
  var _dio;

  ContactUsRepo() {
    _dio = Dio();
  }

  Future<dynamic> contactUsData()async{
    var url = EndPoints.ContactUs;
    print('$LOGD contactUsData URL $url');
    var response;
    ContactUsRes contactUsRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD contactUsData response  ${response}');
      contactUsRes = ContactUsRes.fromJson(response.data);
      print('$LOGD contactUsData response data  ${jsonEncode(contactUsRes)}');
      return response;
    } on DioError catch (e) {
      contactUsRes = ContactUsRes.fromJson(response.data);
      print('$LOGD contactUsData response error  ${e.response}');

      return e.response;
    }
  }

  Future<dynamic> sendMessage(msgReq,token)async{
    var response;
    print('$LOGD sendMessage req: ${jsonEncode(msgReq)}');

    try{
      response = await this._dio.post(
        EndPoints.Message + token,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
        data: jsonEncode(msgReq),
      );
      print('$LOGD sendMessage response : ${response.toString()}');
      return response;
    }on DioError catch(e){
      print('$LOGD sendMessage error : ${e.response.toString()}');
      return e.response;
    }
  }


}