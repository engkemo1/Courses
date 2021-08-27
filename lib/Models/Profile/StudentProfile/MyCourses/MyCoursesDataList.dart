import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesResData.dart';

class MyCoursesDataList {
  MyCoursesResData _coursesResData;

  MyCoursesDataList({ MyCoursesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  String get name => _coursesResData.name;

  String get slug => _coursesResData.slug;

  String get image => _coursesResData.image;

  String get shortDescription => _coursesResData.shortDescription;

  int get price=> _coursesResData.price;

  String get level => _coursesResData.level;

  int get discountPrice => _coursesResData.discountPrice;

  List<Teacher> get teacher => _coursesResData.teachers;

  Map<String, dynamic> get placement => _coursesResData.placement;
  Map<String, dynamic> get finalExam => _coursesResData.finalExam;

  String get teacherImg => _coursesResData.teacherImg;
}