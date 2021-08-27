import 'package:get/get.dart';
import 'package:troom/Controller/Auth/Register/RegisterCont.dart';

class RegisterBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(RegisterCont(), permanent: true);
  }
}