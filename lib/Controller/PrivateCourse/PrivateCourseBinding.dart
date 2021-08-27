import 'package:get/get.dart';
import 'package:troom/Controller/PrivateCourse/PrivateCourseCont.dart';

class PrivateCourseBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(PrivateCourseCont(), permanent: true);
  }
}