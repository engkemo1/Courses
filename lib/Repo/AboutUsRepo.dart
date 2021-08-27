import 'dart:io';
import 'package:dio/dio.dart';
import 'package:troom/Util/EndPoints.dart';

class AboutUsRepo{
  static const LOGD = 'AboutUsRepo-->';
  var _dio;

  AboutUsRepo() {
    _dio = Dio();
  }

  Future<dynamic> aboutUs(appLang) async{
    var url = EndPoints.AboutUs + '?lang=' + appLang;
    print('$LOGD aboutUs URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD aboutUs response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

  Future<dynamic> footer() async{
    var url = EndPoints.Footer;
    print('$LOGD footer URL $url');
    var response;
    try {
      response = await this._dio.get(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json charset=UTF-8",
        }),
      );
      print('$LOGD footer response  ${response}');
      return response;
    } on DioError catch (e) {
      return e.response;
    }
  }

}