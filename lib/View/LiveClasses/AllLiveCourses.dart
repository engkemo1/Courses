import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/AllLiveCourses/AllLiveCoursesCont.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/LiveClasses/LiveCourseDetails.dart';
import 'package:troom/View/LiveClasses/LiveCourseListItem.dart';
import 'package:troom/View/MainDrawer.dart';

class AllLiveCourses extends GetView<AllLiveCoursesCont> {
  static const Id = 'AllLiveCoursesScreen';
  final AllLiveCoursesCont _allLiveCoursesCont = Get.put(AllLiveCoursesCont());
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
            inAsyncCall: _allLiveCoursesCont.modalHudController.isLoading,
            child: Container(child: LayoutBuilder(
              builder: (context, cons) {
                var localW = cons.maxWidth;
                var localH = cons.maxHeight;
                return ListView(
                  children: [
                    SizedBox(
                      height: localH * 0.02,
                    ),

                    //TODO All Live Classes
                    SizedBox(
                      width: localW,
                      height: localH * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            txt: 'AllLiveClasses'.tr,
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
                      height: localH * 0.02,
                    ),

                    //TODO Courses Number
                    Container(
                      width: localW,
                      height: localH * 0.08,
                      margin: EdgeInsets.only(left: localW * 0.075,right: localW * 0.075),
                      child: CustomText(
                        txt: '${'WeFound'.tr} ${_homeCont.liveCoursesList.length} ${'CoursesForYou'.tr}',
                        fontSize: localW * 0.06,
                        txtColor: ConstStyles.BlueColor,
                      ),
                    ),

/*
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: localW * 0.05),
                          child:
                          OrangeBtn(text: 'Show filters', onClick: () {},),
                        ),
                      ],
                    ),
*/



                    //TODO Courses List View
                    GetBuilder<HomeCont>(
                      builder: (_) {
                        return  SizedBox(
                          width: localW,
                          height: localH * 0.8,
                          child: ListView.builder(
                            itemCount: _homeCont.liveCoursesList.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              if(_homeCont.liveCoursesList.length > 0){
                                return InkWell(
                                    onTap: (){
                                      Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[index].key));
                                    },
                                    child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[index],'EgyptianPound'.tr,
                                        'More'.tr));
                              }else{
                                return SizedBox(
                                    width: localW,
                                    height: localH * 0.5,
                                    child: LogoContainer(
                                      // colors: ConstStyles.DarkColor,
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
