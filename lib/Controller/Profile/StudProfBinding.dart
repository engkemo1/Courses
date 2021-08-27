import 'package:get/get.dart';
import 'package:troom/Controller/Profile/StudProfCont.dart';

class StudProfBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(StudProfCont(), permanent: true);
  }

}