import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:troom/Controller/AllCourses/CourseDetailsCont.dart';
import 'package:troom/CustomViews/CustomProfForm.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/PlacementKey/SubmitAnswers/SubmitPlacementTestAnsReq.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class CoursePlacementTest extends StatelessWidget {
  static const Id = 'CoursePlacementTest';
  String LOGD = 'PlacementTest';
  var localH;
  CourseDetailsCont _cont = Get.put(CourseDetailsCont(null));

  CoursePlacementTest({this.localH});

  @override
  Widget build(BuildContext context) {

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Container(
        height:localH,
        child: LayoutBuilder(
          builder: (context,cons){
            var localW = cons.maxWidth;
            return GetBuilder<CourseDetailsCont>(builder: (_){
              if(_cont.placementCurrentView == LocalDataStrings.PlacementTestData){
                return placementData(localW);
              }else if(_cont.placementCurrentView == LocalDataStrings.PlacementTestScore){
                return placementScore(localW);
              }else{
                return placementQuestion(localW);
              }
            });
          },
        ),
      ),
    );
  }

  Widget placementData(localW){
    return ListView(

      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: (){
                  _cont.clearPlacementData();
                },
                child: Icon(Icons.close,color: ConstStyles.BlueColor,)),
          ],
        ),

        SizedBox(
          height: localH,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //TODO Title
                SizedBox(
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        txt: 'Title : ',
                        txtColor: ConstStyles.BlackColor,
                      ),
                      CustomText(
                        txt: _cont.placementExamResData.title == null ? ' ' :
                        _cont.placementExamResData.title,
                        txtColor: ConstStyles.BlackColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: localH * 0.05,),

                //TODO Time
                SizedBox(
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        txt: 'Time : ',
                        txtColor: ConstStyles.BlackColor,
                      ),
                      CustomText(
                        txt: _cont.placementExamResData.time == null ? ' ' :
                        '${_cont.placementExamResData.time}  minutes',
                        txtColor: ConstStyles.BlackColor,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: localH * 0.05,),

                //TODO Start
                OrangeBtn(
                  text: 'Start',
                  txtColor: ConstStyles.WhiteColor,
                  btnColor: Colors.blueAccent,
                  onClick: (){
                    _cont.startTimer();
                    _cont.changePlacementView(LocalDataStrings.PlacementTestQuestions);
                  },
                )
              ],
            ),
          ),
        ),

      ],
    );
  }

  Widget placementScore(localW){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: localW,
          height: localH *0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txt: 'Title : ',
                txtColor: ConstStyles.BlackColor,
              ),
              CustomText(
                txt: _cont.submitPlacementTestAnsResData.title == null ? '':_cont.submitPlacementTestAnsResData.title,
                txtColor: ConstStyles.TextColor,
              ),
            ],
          ),
        ),
        SizedBox(
          width: localW,
          height: localH *0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txt: 'Score : ',
                txtColor: Colors.red,
              ),
              CustomText(
                txt: _cont.submitPlacementTestAnsResData.score == null ? '' :
                '${_cont.submitPlacementTestAnsResData.score} / ${_cont.submitPlacementTestAnsResData.total}',
                txtColor: ConstStyles.TextColor,
              ),
            ],
          ),
        ),
        SizedBox(
          width: localW,
          height: localH *0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                txt: 'Percentage : ',
                txtColor: Colors.red,
              ),
              CustomText(
                txt: _cont.submitPlacementTestAnsResData.rate == null ? '' :
                '${_cont.submitPlacementTestAnsResData.rate} %',
                txtColor: ConstStyles.TextColor,
              ),
            ],
          ),
        ),
        SizedBox(
          width: localW,
          height: localH *0.1,
          child: Center(
            child: OrangeBtn(
              text: 'Ok',txtColor: ConstStyles.WhiteColor,btnColor: ConstStyles.GreenColor,
              onClick: (){
                _cont.clearPlacementData();
              },
            ),
          ),
        ),
      ],
    );
  }


  Widget placementQuestion(localW){
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        SizedBox(
          height: localH * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                txtColor: ConstStyles.TextColor,
                txt: _cont.placementExamResData.title == null ? ' ' :
                _cont.placementExamResData.title,
              ),

              InkWell(
                  onTap: (){
                    _cont.clearPlacementData();
                  },
                  child: Icon(Icons.close,color: ConstStyles.BlackColor,)),
            ],
          ),
        ),
        Divider(
          thickness: 1,
          color: ConstStyles.BlackColor,
        ),

        SizedBox(
          height: localH * 0.1,
          child: GetBuilder<CourseDetailsCont>(builder: (_){
            return CustomText(txt: "Time : ${(_cont.examTimeMin-1).toString()}:${_cont.examTimeSec.toString()} Min",txtColor: ConstStyles.GreenColor,);
          },),),

        SizedBox(
          height: localH ,
          width: localW,
          child: CarouselSlider.builder(
            scrollPhysics: NeverScrollableScrollPhysics(),
            slideBuilder: (index) {
              if (_cont.qNum > 0) {
                return questions(localW,index);
              } else {
                return SizedBox(
                    width: localW,
                    height: localH * 0.3,
                    child: LogoContainer(
                    ));
              }
            },
            slideTransform: CubeTransform(),
            slideIndicator: CircularSlideIndicator(
              padding: EdgeInsets.only(bottom: 32),
            ),
            controller: _cont.questionSliderCont,
            itemCount:  _cont.qNum,
          ),
        ),

      ],
    );
  }

  Widget questions(localW,i){
    return Container(
      color: Colors.grey[100],
      child: ListView.builder(
          itemCount: _cont.placementExamResData.sections[i].questions.length,
          itemBuilder: (context,questionIndex){
            return Column(
              children: [
                //TODO Section Title
                SizedBox(
                  width: localW,
                  height: localH * 0.05,
                  child: Center(
                    child: CustomText(
                      txtColor: ConstStyles.BlackColor,
                      txt: _cont.placementExamResData.sections == null ? ' ' :
                      _cont.placementExamResData.sections[i].title,
                      fontSize: localW,
                    ),
                  ),
                ),

                SizedBox(
                  height: localH * 0.5,
                  width: localW,
                  child:
                  ListView.builder(
                    itemBuilder: (context,Qindex){
                      return Container(
                        margin: EdgeInsets.only(bottom: localH * 0.03),
                        child: Column(
                          children: [
                            //TODO Question
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: localW * 0.1,
                                  child: CustomText(txt: "${'Q'.tr}${i+1} : ",fontWeight: FontWeight.bold,txtColor: ConstStyles.BlackColor,fontSize: localW * 0.06,),
                                ),
                                Container(
                                  width: localW * 0.78,
                                  child: CustomText(txt: "${_cont.placementExamResData.sections[i].questions[Qindex].question} ?",txtColor: ConstStyles.TextColor  ,),

                                ),
                              ],
                            ),

                            //TODO Answers
                            SizedBox(
                              height: localH * 0.25,
                              width:localW,
                              child: ListView.builder(
                                itemCount: _cont.placementExamResData.sections[i].questions[Qindex].answers.length,
                                itemBuilder: (context,answerIndex){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      RadioGroup<String>.builder(
                                        activeColor: ConstStyles.GreenColor,
                                        groupValue: _cont.placementSelectedAnswers[i] == null ? 'loading...':_cont.placementSelectedAnswers[i],
                                        onChanged: (selected){
                                          print('LessonExam ::: ${_cont.placementExamResData.sections[i].questions[Qindex].answers[answerIndex].key}');
                                          _cont.changeSelectedPlacementValue(selected, i);
                                          if(_cont.placementExamResData.sections[i].questions[Qindex].answers[answerIndex].key == _cont.placementExamResData.sections[i].questions[Qindex].correctAnswer){
                                            print('RadioGroupSelected Result === True');
                                            _cont.placementAnswersResult.insert(i, true);
                                          }else{
                                            print('RadioGroupSelected Result === False');
                                            _cont.placementAnswersResult.insert(i,false);
                                          }
                                        },
                                        items: [_cont.placementExamResData.sections[i].questions[Qindex].answers[answerIndex].answer],
                                        itemBuilder: (item) => RadioButtonBuilder(_cont.placementExamResData.sections[i].questions[Qindex].answers[answerIndex].answer),
                                      )


                                    ],
                                  );
                                },),
                            ),

                            // Container(
                            //
                            //   child: Divider(
                            //     thickness: 2,
                            //     color: ConstStyles.BlackColor,
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                    itemCount: _cont.placementExamResData.sections[i].questions.length == null ? 0 : _cont.placementExamResData.sections[i].questions.length,
                  ),

                ),

                GetBuilder<CourseDetailsCont>(
                    builder: (_){
                      if(i+1 > _cont.qNum){
                        return OrangeBtn(
                          txtColor: ConstStyles.WhiteColor,
                          text: 'Submit',
                          btnColor: Colors.blueAccent,
                          onClick: (){
                          },
                        );
                      }else{
                        return OrangeBtn(
                          txtColor: ConstStyles.WhiteColor,
                          text: 'Next',
                          btnColor: Colors.blueAccent,
                          onClick: (){
                            print('$LOGD SubmitselectedAnswers: ${_cont.placementExamResData.sections[i].questions[questionIndex].answers[questionIndex].key}');
                            // _cont.answersList.forEach((element) {
                            //   print('$LOGD SubmitanswersResult: ${element}');
                            // });
                            _cont.nextQuestion(i,questionIndex,_cont.placementExamResData.sections[i].questions[questionIndex].answers[questionIndex].key);
                          },
                        );
                      }

                    }),
              ],
            );
          }),
    );
  }


}
