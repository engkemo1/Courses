import 'package:get/get.dart';
import 'package:troom/Controller/AllLiveCourses/AllLiveCoursesCont.dart';

class AllLiveCoursesBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AllLiveCoursesCont(), permanent: true);
  }
}