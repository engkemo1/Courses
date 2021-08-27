import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonsResData.dart';

class ShowMyClassesLessonDataList{
  ShowMyClassesResData _coursesResData;

  ShowMyClassesLessonDataList({ ShowMyClassesResData data}) : _coursesResData = data;


  int get key => _coursesResData.key;

  String get name => _coursesResData.name;

  String get day => _coursesResData.day;

  String get date => _coursesResData.date;

  String get time => _coursesResData.time;

  String get status => _coursesResData.status;

  bool get meeting => _coursesResData.meeting;
}