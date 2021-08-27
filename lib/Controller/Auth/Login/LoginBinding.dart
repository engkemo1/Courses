import 'package:get/get.dart';
import 'package:troom/Controller/Auth/Login/LoginCont.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginCont(), permanent: true);
  }
}