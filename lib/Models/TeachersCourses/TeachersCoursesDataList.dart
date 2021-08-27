import 'package:troom/Models/TeachersCourses/TeachersCoursesResData.dart';

class TeachersCoursesDataList{

  TeachersCoursesResData _teachersCoursesResData;

  TeachersCoursesDataList({ TeachersCoursesResData data}) : _teachersCoursesResData = data;

  int get key => _teachersCoursesResData.key;

  String get name => _teachersCoursesResData.name;

  String get slug => _teachersCoursesResData.slug;

  int get price => _teachersCoursesResData.price;

  String get level => _teachersCoursesResData.level;

  int get discountPrice => _teachersCoursesResData.discountPrice;

  String get category => _teachersCoursesResData.category;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeachersCoursesDataList &&
          runtimeType == other.runtimeType &&
          _teachersCoursesResData == other._teachersCoursesResData;

  @override
  int get hashCode => _teachersCoursesResData.hashCode;
}