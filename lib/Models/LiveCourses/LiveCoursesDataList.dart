import 'package:troom/Models/LiveCourses/LiveCoursesResData.dart';

class LiveCoursesDataList{
  LiveCourseResData _liveCourseResData;

  LiveCoursesDataList({ LiveCourseResData data}) : _liveCourseResData = data;

  int get key => _liveCourseResData.key;

  dynamic get name => _liveCourseResData.name;

  String get slug => _liveCourseResData.slug;

  String get image => _liveCourseResData.image;

  String get shortDescription => _liveCourseResData.shortDescription;

  int get price => _liveCourseResData.price;

  String get level => _liveCourseResData.level;

  int get discountPrice => _liveCourseResData.discountPrice;

  String get teacher => _liveCourseResData.teacher;

  String get teacherImg => _liveCourseResData.teacherImg;

  String get category => _liveCourseResData.category;

  DateTime get startTime => _liveCourseResData.startTime;
}