
import 'package:troom/Models/Features/FeaturesResData.dart';

class FeaturesDataList{
  FeaturesResData _featuresResData;

  FeaturesDataList({ FeaturesResData data}) : _featuresResData = data;


  int get key => _featuresResData.key;

  String get name => _featuresResData.name;

  String get image => _featuresResData.image;

  String get description => _featuresResData.description;
}