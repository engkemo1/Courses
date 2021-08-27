import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/CustomViews/CustomProfForm.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Util/ConstStyles.dart';

class ReqPrivateCourse extends StatelessWidget {
  static const Id = 'ReqPrivateCourse';
  String LOGD = 'ReqPrivateCourse';
  var localH;
  HomeCont _cont = Get.put(HomeCont());
  var _formKey = GlobalKey<FormState>();

  ReqPrivateCourse({this.localH});

  @override
  Widget build(BuildContext context) {
    print('$LOGD Height= $localH');
    return Container(
      height:localH,
      width: MediaQuery.of(context).size.width,
      child: LayoutBuilder(
        builder: (context,cons){
          var localW = cons.maxWidth;
          print('$LOGD Width= $localW');
          return Container(
            width: localW,
            height: localH,
            child:
            ListView(
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(Icons.close,color: ConstStyles.DarkColor,)),
                  ],
                ),
                SizedBox(height: localH * 0.03,),
                //TODO Drop Down
                Container(
                  height: localH * 0.1,
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //TODO Choose Teacher
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW * 0.48,
                              child: CustomText(
                                txt: 'ChooseTeacher'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),
                            //TODO Teachers List
                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              height: localH * 0.055,
                              width: localW * 0.48,
                              child: InkWell(
                                onTap: (){
                                  // if(_courseDetailsCont.getLessonList(index).length <= 0 ){
                                  //   Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                  //       colorText: ConstStyles.WhiteColor,
                                  //       titleText: CustomText(txt: 'NoLessonsAvailable'.tr,
                                  //         txtAlign: TextAlign.center,));
                                  // }
                                },
                                child: DropdownButton(
                                  items: _cont.ourTeachersList
                                      .map((teacher) {
                                    return DropdownMenuItem<String>(
                                      value: teacher.name,
                                      child:  SizedBox(
                                        width: localW * 0.367,
                                        height: localH * 0.035,
                                        child: InkWell(
                                          onTap: (){
                                            print('$LOGD Selected Teacher Id: ${teacher.key}');
                                            _cont.changeTeacher(teacher.name,teacher.key);
                                          },
                                          child:  CustomText(
                                            txt: teacher.name,
                                            fontSize: localW * 0.05,
                                            txtColor:
                                            ConstStyles.DarkColor,
                                            txtAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    // print('$LOGD $teacher');
                                    // _cont.changeTeacher(value);
                                  },
                                  value: _cont.selectedTeacher,
                                  dropdownColor: ConstStyles.WhiteColor,
                                  icon:Icon(Icons.arrow_drop_down,color: ConstStyles.BlackColor,),
                                  iconEnabledColor:
                                  ConstStyles.WhiteColor,
                                  elevation: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TODO Choose Course
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW * 0.48,
                              child: CustomText(
                                txt: 'ChooseCourse'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),
                            Container(
                                decoration: BoxDecoration(
                                  color: ConstStyles.WhiteColor,
                                  border: Border.all(color: Colors.black12),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                height: localH * 0.055,
                                width: localW * 0.48,
                                child: GetBuilder<HomeCont>(
                                  builder: (_){
                                    return DropdownButton(
                                      items: _cont.teachersCoursesList
                                          .map((teacher) {
                                        return DropdownMenuItem<String>(
                                          value: teacher.slug,
                                          child:  Container(
                                            width: localW * 0.367,
                                            height: localH * 0.035,
                                            child: InkWell(
                                              onTap: (){
                                                _cont.changeCourse(teacher.slug,teacher.key);
                                                print('$LOGD TeachersCoursesSelectedCourse : ${_cont.selectedCourse}');
                                                print('$LOGD TeachersCoursesSelectedCourseListLength : ${_cont.teachersCoursesList.length}');
                                                print('$LOGD TeachersCoursesSelectedCourseItemValue : ${teacher.name}');
                                              },
                                              child:  CustomText(
                                                txt: teacher.slug,
                                                fontSize: localW * 0.05,
                                                txtColor:
                                                ConstStyles.DarkColor,
                                                txtAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        // Get.appUpdate();
                                      },
                                      value: _cont.selectedCourse ,
                                      dropdownColor: ConstStyles.WhiteColor,
                                      icon:Icon(Icons.arrow_drop_down,color: ConstStyles.BlackColor,),
                                      iconEnabledColor:
                                      ConstStyles.WhiteColor,
                                      elevation: 10,
                                    );
                                    if(_cont.teachersCoursesList != null && _cont.teachersCoursesList.isNotEmpty &&
                                        _cont.selectedCourse != null && _cont.selectedCourse.isNotEmpty ){
                                      return  DropdownButton(
                                        items: _cont.liveCoursesList
                                            .map((teacher) {
                                          return DropdownMenuItem<String>(
                                            value: teacher.name,
                                            child:  Container(
                                              width: localW * 0.367,
                                              height: localH * 0.035,
                                              child: InkWell(
                                                onTap: (){
                                                  _cont.changeCourse(teacher.name,teacher.key);
                                                  print('$LOGD TeachersCoursesSelectedCourse : ${_cont.selectedCourse}');
                                                  print('$LOGD TeachersCoursesSelectedCourseListLength : ${_cont.teachersCoursesList.length}');
                                                  print('$LOGD TeachersCoursesSelectedCourseItemValue : ${teacher.name}');
                                                },
                                                child:  CustomText(
                                                  txt: teacher.name,
                                                  fontSize: localW * 0.05,
                                                  txtColor:
                                                  ConstStyles.DarkColor,
                                                  txtAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          // Get.appUpdate();
                                        },
                                        value: _cont.selectedCourse ,
                                        dropdownColor: ConstStyles.WhiteColor,
                                        icon:Icon(Icons.arrow_drop_down,color: ConstStyles.BlackColor,),
                                        iconEnabledColor:
                                        ConstStyles.WhiteColor,
                                        elevation: 10,
                                      );
                                    }else{
                                      return  DropdownButton(
                                        items: _cont.liveCoursesList
                                            .map((teacher) {
                                          return DropdownMenuItem<String>(
                                            value: teacher.name,
                                            child:  Container(
                                              width: localW * 0.367,
                                              height: localH * 0.035,
                                              child: InkWell(
                                                onTap: (){
                                                  _cont.changeCourse(teacher.name,teacher.key);
                                                  print('$LOGD TeachersCoursesSelectedCourse : ${_cont.selectedCourse}');
                                                  print('$LOGD TeachersCoursesSelectedCourseListLength : ${_cont.teachersCoursesList.length}');
                                                  print('$LOGD TeachersCoursesSelectedCourseItemValue : ${teacher.name}');
                                                },
                                                child:  CustomText(
                                                  txt: teacher.name,
                                                  fontSize: localW * 0.05,
                                                  txtColor:
                                                  ConstStyles.DarkColor,
                                                  txtAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          // Get.appUpdate();
                                        },
                                        value: _cont.selectedCourse ,
                                        dropdownColor: ConstStyles.WhiteColor,
                                        icon:Icon(Icons.arrow_drop_down,color: ConstStyles.BlackColor,),
                                        iconEnabledColor:
                                        ConstStyles.WhiteColor,
                                        elevation: 10,
                                      );
                                    }
                                  },
                                )

                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                //TODO Select Date
                Container(
                  height: localH * 0.1,
                  width: localW,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: localH * 0.04,
                        width: localW ,
                        child: CustomText(
                          txt: 'EnterAppropriateDate'.tr,
                          txtColor: ConstStyles.TextColor,
                        ),
                      ),

                      Container(
                        decoration: BoxDecoration(
                          color: ConstStyles.WhiteColor,
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                        height: localH * 0.055,
                        width: localW ,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              txt: _cont.startDate == null ? '': _cont.startDate,
                              txtColor: ConstStyles.BlackColor,
                              txtAlign: TextAlign.center,
                            ),
                            GestureDetector(
                              child: Icon(Icons.date_range,color: ConstStyles.BlackColor,size: localH * 0.045,),
                              onTap: (){
                                _cont.selectDate(context);
                              },),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                //TODO Sat & Sun
                Container(
                  height: localH * 0.1,
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //TODO Sat
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Saturday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedSat == null ? '': _cont.selectedSat,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectSatTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TODO Sun
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Sunday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedSun == null ? '': _cont.selectedSun,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectSunTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                //TODO Mon & Tue
                Container(
                  height: localH * 0.1,
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //TODO Mon
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Monday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedMon == null ? '': _cont.selectedMon,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectMonTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TODO Tue
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Tuesday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedTue == null ? '': _cont.selectedTue,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectTueTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                //TODO Wed & Thu
                Container(
                  height: localH * 0.1,
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //TODO Wed
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Wednesday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedWed == null ? '': _cont.selectedWed,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectWedTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TODO Thu
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Thursday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedThu == null ? '': _cont.selectedThu,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectThuTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                //TODO Fri & Note
                Container(
                  height: localH * 0.2,
                  width: localW,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      //TODO Fri
                      SizedBox(
                        height: localH * 0.1,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Friday'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.WhiteColor,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                              height: localH * 0.055,
                              width: localW ,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    txt: _cont.selectedFri == null ? '': _cont.selectedFri,
                                    txtColor: ConstStyles.BlackColor,
                                    txtAlign: TextAlign.center,
                                  ),
                                  GestureDetector(
                                    child: Icon(Icons.timer_rounded,color: ConstStyles.BlackColor,size: localH * 0.045,),
                                    onTap: (){
                                      _cont.selectFriTime(context);
                                    },),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //TODO Note
                      SizedBox(
                        height: localH * 0.2,
                        width: localW * 0.48,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: localH * 0.04,
                              width: localW ,
                              child: CustomText(
                                txt: 'Note'.tr,
                                txtColor: ConstStyles.TextColor,
                              ),
                            ),

                            Form(
                              key: _formKey,
                              child: Container(
                                  decoration: BoxDecoration(
                                    color: ConstStyles.WhiteColor,
                                    border: Border.all(color: Colors.black12),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  // padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                                  height: localH * 0.16,
                                  width: localW ,
                                  child: CustomProfForm(
                                    myController: TextEditingController(
                                        text: _cont.note == null ? '' : _cont.note
                                    ),
                                    keybord: TextInputType.text,
                                    onSave: (v){
                                      _cont.note = v;
                                    },
                                    onChange: (v){
                                      _cont.note = v;
                                    },
                                    minLines: 4,
                                    maxLin: 30,
                                  )
                                /*         Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomText(
                                            txt: _cont.note == null ? '': _cont.note,
                                            txtColor: ConstStyles.BlackColor,
                                            txtAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),*/
                              ),
                            ),
                          ],
                        ),
                      ),



                    ],
                  ),
                ),

                SizedBox(height: localH * 0.03,),

                OrangeBtn(
                  text: 'Ok'.tr,
                  onClick: ()async{
                    _formKey.currentState.save();
                    await _cont.preparePrivateCourseReq();
                    if(_cont.privateReqComplete){
                      Get.back(result: "success");
                    }else{
                      Get.back();
                    }
                    // Get.back(result: "success");
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
