import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/AllCourses/CourseDetailsCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/QuizChapter/QuizChapterQuestionList.dart';
import 'package:troom/Util/ConstStyles.dart';

class ChapterExam extends StatelessWidget {
  static const Id = 'ChapterExamView';
  var _chapterName = '';
  var _chapterKey ;
   List<QuizChapterQuestionList> _questionsList = [];
   CourseDetailsCont _cont;

  ChapterExam(this._chapterName, this._questionsList,this._chapterKey){
    _cont = Get.put(CourseDetailsCont(null));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(builder: (_){
          return ModalProgressHUD(
            inAsyncCall: _cont.modalHudController.isLoading,
            child: Container(
              child: LayoutBuilder(
                builder: (context,cons){
                  var localW = cons.maxWidth;
                  var localH = cons.maxHeight;
                  return GetBuilder<CourseDetailsCont>(
                    builder: (_){
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          //TODO Lesson Exam Title
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    SizedBox(height: localH * 0.02,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          child: AutoTextSize(
                                            text: 'Exam'.tr,
                                            size: localW * 0.07,
                                            textColor: ConstStyles.OrangeColor,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                        SizedBox(
                                          width: localW * 0.7,
                                          child: AutoTextSize(
                                            text: ' '+ _chapterName,
                                            size: localW * 0.07,
                                            textColor: ConstStyles.BlackColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: Divider(
                                        thickness: 5,
                                        color: ConstStyles.OrangeColor,
                                      ),
                                    ),

                                    SizedBox(height: localH * 0.1,),

                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Container(
                                        padding: EdgeInsets.only(left: localW * 0.05,right: localW * 0.05),
                                        height: localH * 0.7,
                                        child: ListView.builder(
                                            itemCount: _questionsList.length,
                                            itemBuilder:(context,index){

                                              return Container(
                                                margin: EdgeInsets.only(bottom: localH * 0.03),
                                                child: Column(
                                                  children: [
                                                    //TODO Question
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: localW * 0.1,
                                                          child: CustomText(txt: "${'Q'.tr}${index+1} : ",fontWeight: FontWeight.bold,txtColor: ConstStyles.BlackColor,fontSize: localW * 0.06,),
                                                        ),
                                                        Container(
                                                          width: localW * 0.78,
                                                          child: AutoTextSize(text: "${_questionsList[index].question} ?",),

                                                        ),
                                                      ],
                                                    ),

                                                    //TODO Answers
                                                    SizedBox(
                                                      height: localH * 0.25,
                                                      width:localW,
                                                      child: ListView.builder(
                                                        itemCount: _questionsList[index].answersList.length,
                                                        itemBuilder: (context,answerIndex){
                                                          return Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              RadioGroup<String>.builder(
                                                                activeColor: ConstStyles.GreenColor,
                                                                groupValue: _cont.selectedAnswers[index] == null ? 'loading...':_cont.selectedAnswers[index],
                                                                onChanged: (selected){
                                                                  print('LessonExam ::: ${_cont.selectedAnswers[index]}');
                                                                  _cont.changeSelectedValue(selected, index);
                                                                  if(_cont.questionChapterList[index].answersList[answerIndex].key == _cont.questionChapterList[index].correctAnswer){
                                                                    print('RadioGroupSelected Result === True');
                                                                    _cont.answersResult.insert(index, true);
                                                                  }else{
                                                                    print('RadioGroupSelected Result === False');
                                                                    _cont.answersResult.insert(index,false);
                                                                  }
                                                                },
                                                                items: [_questionsList[index].answersList[answerIndex].answer],
                                                                itemBuilder: (item) => RadioButtonBuilder(_questionsList[index].answersList[answerIndex].answer),
                                                              )
                                                            ],
                                                          );
                                                        },),
                                                    ),


                                                    GetBuilder<CourseDetailsCont>(builder: (_){
                                                      if(_cont.checkAnswers.isNotEmpty){
                                                        return      Icon(_cont.checkAnswers[index] == false ? Icons.close
                                                            : Icons.check ,
                                                          color: _cont.checkAnswers[index] == false ? Colors.red : Colors.green,);
                                                      }else {
                                                        return Container();
                                                      }
                                                    }),

                                                    Container(

                                                      child: Divider(
                                                        thickness: 2,
                                                        color: ConstStyles.BlackColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            } ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),



                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: OrangeBtn(text: 'SubmitAnswers'.tr, onClick: (){
                                _cont.submitChapterAnswers(_chapterKey);
                              }),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },),
      ),
    );
  }
}
