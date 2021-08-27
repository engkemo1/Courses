import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesResData.dart';

class MyClassesDataList{
  MyClassesResData _coursesResData;

  MyClassesDataList({ MyClassesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  String get name => _coursesResData.name;

  List<Teacher> get teacher => _coursesResData.teachers;

  int get weeks => _coursesResData.weeks;

  int get lessons => _coursesResData.lessons;

  String get lessonTime => _coursesResData.lessonTime;
}