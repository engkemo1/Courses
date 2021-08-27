import 'package:get/get.dart';
import 'package:troom/Controller/AllCourses/AllCoursesCont.dart';

class AllCoursesBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(AllCoursesCont(), permanent: true);
  }
}