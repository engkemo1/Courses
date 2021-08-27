import 'package:troom/Models/QuizLesson/QuizLessonResData.dart';

class QuizLessonQuestionsList{

  QuizLessonResData _quizLessonResData;

  QuizLessonQuestionsList({ QuizLessonResData data}) : _quizLessonResData = data;

  int get key => _quizLessonResData.key;

  String get question => _quizLessonResData.quistion;

  int get correctAnswer => _quizLessonResData.correctAnswer;

  List<Answer> get answersList => _quizLessonResData.answers;
}