import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/AllCourses/AllCoursesCont.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/Courses/CourseDetails.dart';
import 'package:troom/View/Courses/CourseListItem.dart';
import 'package:troom/View/MainDrawer.dart';

class AllCourses extends GetView<AllCoursesCont> {
  static const Id = 'AllCoursesScreen';
  final AllCoursesCont _allCoursesCont = Get.put(AllCoursesCont());
  final HomeCont _homeCont = Get.put(HomeCont());

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      drawer: MainDrawer(),
      body: SafeArea(child: GetBuilder<ModalHudCont>(
        builder: (_) {
          return ModalProgressHUD(
            inAsyncCall: _allCoursesCont.modalHudController.isLoading,
            child: Container(
                child: LayoutBuilder(
              builder: (context, cons) {
                var localW = cons.maxWidth;
                var localH = cons.maxHeight;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: localH * 0.02,
                    ),

                    //TODO Our Courses
                    SizedBox(
                      height: localH * 0.055,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            txt: 'AllRecordedCourses'.tr,
                            fontSize: localW * 0.09,
                            txtColor: ConstStyles.DarkColor,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          right: localW * 0.25, left: localW * 0.25),
                      child: Divider(
                        thickness: 5,
                        color: ConstStyles.OrangeColor,
                      ),
                    ),

                    SizedBox(
                      height: localH * 0.05,
                    ),

                    //TODO Courses Number
                    Container(
                      height: localH * 0.05,
                      margin: EdgeInsets.only(left: localW * 0.05,right: localW * 0.05),
                      child: CustomText(
                        txt: '${'WeFound'.tr} ${_homeCont.coursesList.length} ${'CoursesForYou'.tr}',
                        fontSize: localW * 0.05,
                        txtColor: ConstStyles.BlueColor,
                      ),
                    ),
                    SizedBox(
                      height: localH * 0.03,
                    ),

                    //TODO Courses List View
                    GetBuilder<HomeCont>(
                      builder: (_) {
                        return SizedBox(
                          width: localW,
                          height: localH * 0.75,
                          child: ListView.builder(
                            itemCount: _homeCont.coursesList != null
                                ? _homeCont.coursesList.length
                                : 3,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if (_homeCont.coursesList.length > 0) {
                                return InkWell(
                                  onTap: (){
                                    Get.to( () => CourseDetails(_homeCont.coursesList[index].key));
                                  },
                                  child: CourseListItem(localH * 0.7, localW,
                                      _homeCont.coursesList[index],"${'EgyptianPound'.tr}"),
                                );
                              } else {
                                return SizedBox(
                                    width: localW,
                                    height: localH * 0.5,
                                    child: LogoContainer(
                                        ));
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            )),
          );
        },
      )),
    );
  }
}
