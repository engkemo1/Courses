
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';

class HomeContBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(HomeCont(), permanent: true);
  }
}