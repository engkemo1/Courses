import 'package:get/get.dart';
import 'package:troom/Controller/AboutUs/AboutUsBinding.dart';
import 'package:troom/Controller/AllCourses/AllCoursesBinding.dart';
import 'package:troom/Controller/AllLiveCourses/AllLiveCoursesBinding.dart';
import 'package:troom/Controller/Auth/Login/LoginBinding.dart';
import 'package:troom/Controller/Auth/Register/RegisterBinding.dart';
import 'package:troom/Controller/ContactUs/ContactUsBinding.dart';
import 'package:troom/Controller/HomePage/HomeContrBinding.dart';
import 'package:troom/Controller/Drawer/MainDrawerBinding.dart';
import 'package:troom/Controller/PrivateCourse/PrivateCourseBinding.dart';
import 'package:troom/Controller/Profile/StudProfBinding.dart';
import 'package:troom/Controller/Splash/SplashBinding.dart';
import 'package:troom/View/AboutUs.dart';
import 'package:troom/View/ContactUs.dart';
import 'package:troom/View/Courses/AllCourses.dart';
import 'package:troom/View/LiveClasses/AllLiveCourses.dart';
import 'package:troom/View/Auth/Login.dart';
import 'package:troom/View/Auth/Register.dart';
import 'package:troom/View/Home.dart';
import 'package:troom/View/LiveClasses/ReqPrivateCourse.dart';
import 'package:troom/View/MainDrawer.dart';
import 'package:troom/View/Splash.dart';
import 'package:troom/View/StudentProfile/StudentProfile.dart';

class Pages{

  static final routes = [

    GetPage(
      name: Splash.Id,
      page: () => Splash(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Register.Id,
      page: () => Register(),
      binding: RegisterBinding(),
    ),


    GetPage(
      name: Login.Id,
      page: () => Login(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Home.Id,
      page: () => Home(),
      binding: HomeContBinding(),
    ),

    GetPage(
      name: ReqPrivateCourse.Id,
      page: () => ReqPrivateCourse(),
      binding: PrivateCourseBinding(),
    ),

    GetPage(
      name: MainDrawer.Id,
      page: () => MainDrawer(),
      binding: MainDrawerBinding(),
    ),


    GetPage(
      name: StudentProfile.Id,
      page: () => StudentProfile(),
      binding: StudProfBinding(),
    ),

    GetPage(
      name: AllCourses.Id,
      page: () => AllCourses(),
      binding: AllCoursesBinding(),
    ),



    GetPage(
      name: AllLiveCourses.Id,
      page: () => AllLiveCourses(),
      binding: AllLiveCoursesBinding(),
    ),

    GetPage(
      name: AboutUs.Id,
      page: () => AboutUs(),
      binding: AboutUsBinding(),
    ),

    GetPage(
      name: ContactUs.Id,
      page: () => ContactUs(),
      binding: ContactUsBinding(),
    ),

  ];
}