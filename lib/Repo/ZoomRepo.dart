import 'dart:io';

import 'package:dio/dio.dart';
import 'package:troom/Models/ZoomMeeting/ShowMeeting/ShowMeetingRes.dart';
import 'package:troom/Models/ZoomMeeting/ZoomCredential/ZoomCredRes.dart';
import 'package:troom/Util/EndPoints.dart';

class ZoomRepo{
  static const LOGD = 'ZoomRepo-->';
  var _dio;

  ZoomRepo() {
    _dio = Dio();
  }

  Future<dynamic> showMeeting(lessonKey,token) async{

    var url = EndPoints.ShowMeeting + '/' + lessonKey.toString() + '?token=' + token;
    print('$LOGD showMeeting URL $url');
    var response;
    ShowMeetingRes showMeetingRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD showMeeting response  ${response}');
      showMeetingRes = ShowMeetingRes.fromJson(response.data);
      print('$LOGD showMeeting response details  ${showMeetingRes}');
      return response;
    } on DioError catch (e) {
      showMeetingRes = ShowMeetingRes.fromJson(response.data);
      return e.response;
    }
  }

  Future<dynamic> zoomCredential(token) async{

    var url = EndPoints.ZoomCredential + token;
    print('$LOGD zoomCredential URL $url');
    var response;
    ZoomCredRes zoomCredRes;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD zoomCredential response  ${response}');
      zoomCredRes = ZoomCredRes.fromJson(response.data);
      print('$LOGD zoomCredential response details  ${zoomCredRes}');
      return response;
    } on DioError catch (e) {
      zoomCredRes = ZoomCredRes.fromJson(response.data);
      return e.response;
    }
  }


}