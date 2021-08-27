import 'package:get/get.dart';
import 'package:troom/Controller/Splash/SplashCont.dart';

class SplashBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(SplashCont(), permanent: true);
  }
}