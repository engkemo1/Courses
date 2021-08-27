import 'package:get/get.dart';
import 'package:troom/Controller/Drawer/MainDrawerCont.dart';

class MainDrawerBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(MainDrawerCont(), permanent: true);
  }
}