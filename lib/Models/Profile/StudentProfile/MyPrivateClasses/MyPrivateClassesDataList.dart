
import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesResData.dart';

class MyPrivateClassesDataList{
  MyPrivateClassesResData _coursesResData;

  MyPrivateClassesDataList({ MyPrivateClassesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  String get name => _coursesResData.name;

  String get type => _coursesResData.type;

  String get teacher => _coursesResData.teacher;

  int get weeks => _coursesResData.weeks;


  int get lessons => _coursesResData.lessons;

  String get lessonTime => _coursesResData.lessonTime;
}