import 'package:troom/Models/QuizChapter/QuizChapterResData.dart';

class QuizChapterQuestionList{
  QuizChapterResData _quizLessonResData;

  QuizChapterQuestionList({ QuizChapterResData data}) : _quizLessonResData = data;

  int get key => _quizLessonResData.key;

  String get question => _quizLessonResData.question;

  int get correctAnswer => _quizLessonResData.correctAnswer;

  List<Answer> get answersList => _quizLessonResData.answers;
}