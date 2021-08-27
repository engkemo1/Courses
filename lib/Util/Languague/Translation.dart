import 'package:get/get.dart';
import 'package:troom/Util/Languague/Arabic.dart';
import 'package:troom/Util/Languague/English.dart';

class Translation extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en':English,
    'ar':Arabic,
  };
}