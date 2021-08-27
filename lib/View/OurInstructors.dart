import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/Instructors/Inst.dart';
import 'package:troom/Models/Instructors/InstructorsDetails.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/Instructors%20Details.dart';
import 'package:troom/View/MainDrawer.dart';

class OurInstructor extends StatelessWidget {
  static const Id = 'OurInstructorView';
  InsApi i =InsApi();
  final HomeCont _homeCont = Get.put(HomeCont());

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.contain,
          height: appBarH,
        ),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      drawer: MainDrawer(),
      body: SafeArea(child: GetBuilder<ModalHudCont>(
        builder: (_) {
          return ModalProgressHUD(
            inAsyncCall: false,
            child: Container(child: LayoutBuilder(
              builder: (context, cons) {
                var localW = cons.maxWidth;
                var localH = cons.maxHeight;
                return ListView(
                  children: [
                    SizedBox(
                      height: localH * 0.02,
                    ),

                    //TODO Our Instructor
                    SizedBox(
                      width: localW,
                      height: localH * 0.07,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            txt: 'Teachers'.tr,
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

                    //TODO Instructors Number

                    Container(
                        width: localW,
                        height: localH * 0.08,
                        margin: EdgeInsets.only(
                            left: localW * 0.075, right: localW * 0.075),
                        child: CustomText(
                          txt:
                          '${'WeFound'.tr} ${_homeCont.ourTeachersList
                              .length}  ${'TeachersForYou'.tr}',
                          fontSize: localW * 0.06,
                          txtColor: ConstStyles.BlueColor,

                        )
                    ),
                    //TODO Instructors List View
                    GetBuilder<HomeCont>(
                      builder: (_) {
                        return SizedBox(
                            width: localW,
                            height: localH * 0.8,

                            child: FutureBuilder<List<InstData>>(future:i.FetchDataInst() ,
                                builder: (context,snapShot){
                                  return ListView.builder(
                                    itemCount:snapShot.data!=null? snapShot.data.length:0,

                                    scrollDirection: Axis.vertical,
                                    itemBuilder: (context, index) {
                                      if (snapShot.data.length> 0) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => InstructorScreen(
                                                      t: snapShot
                                                          .data[index],
                                                    )));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: localW * 0.05,
                                                right: localW * 0.05,
                                                bottom: localW * 0.05),
                                            decoration: BoxDecoration(
                                              color: ConstStyles.WhiteColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20.0)),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 2.0,
                                                  spreadRadius: 1.0,
                                                  offset: Offset(2.0,
                                                      2.0), // shadow direction: bottom right
                                                )
                                              ],
                                            ),
                                            child: ourTeacherListItem(localW, localH,
                                                snapShot.data[index]),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                            width: localW,
                                            height: localH * 0.5,
                                            child: LogoContainer());
                                      }
                                    },
                                  );

                                }
                            )
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

  //TODO Our Teacher List Item
  Widget ourTeacherListItem(localW, localH, InstData item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: localW,
          height: localH * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(EndPoints.ImageUrl + item.image.toString()),
              fit: BoxFit.contain,
            ),
          ),
        ),
        CustomText(
          txt: item.name,
          txtColor: ConstStyles.TextColor,
          fontSize: localW * 0.08,
        ),
      ],
    );
  }
}
