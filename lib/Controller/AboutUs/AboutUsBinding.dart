import 'package:get/get.dart';
import 'package:troom/Controller/AboutUs/AboutUsCont.dart';

class AboutUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AboutUsCont(), permanent: true);
  }
}