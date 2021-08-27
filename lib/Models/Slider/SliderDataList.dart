import 'package:troom/Models/Slider/SliderResData.dart';

class SliderDataList{
SliderResData _sliderResData;

SliderDataList({ SliderResData data}) : _sliderResData = data;


int get key => _sliderResData.key;

String get name => _sliderResData.name;

String get image => _sliderResData.image;

String get paragraph => _sliderResData.paragraph;

String get btnName => _sliderResData.btnName;

String get btnUrl => _sliderResData.btnUrl;

String get direction => _sliderResData.direction;
}