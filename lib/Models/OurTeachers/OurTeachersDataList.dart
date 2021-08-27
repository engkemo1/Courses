import 'package:troom/Models/OurTeachers/OurTeachersResData.dart';

class OurTeachersDataList {
  OurTeachersResData _ourTeachersResData;

  OurTeachersDataList({ OurTeachersResData data}) : _ourTeachersResData = data;

  int get key => _ourTeachersResData.key;

  String get name => _ourTeachersResData.name;

  String get image => _ourTeachersResData.image;
}