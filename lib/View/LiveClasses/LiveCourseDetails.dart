import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:troom/Controller/AllLiveCourses/LiveCourseDetailsCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Auth/Login.dart';
import 'package:troom/View/Auth/Register.dart';
import 'package:troom/View/Courses/PayPalView.dart';
import 'package:troom/View/MainDrawer.dart';

class LiveCourseDetails extends StatelessWidget {
  LiveCourseDetailsCont _courseDetailsCont;
  var _courseKey;

  LiveCourseDetails(this._courseKey) {
    _courseDetailsCont = Get.put(LiveCourseDetailsCont(_courseKey.toString()));
  }

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
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(
          builder: (_) {
            return ModalProgressHUD(
              inAsyncCall: _courseDetailsCont.modalHudController.isLoading,
              child: Container(
                child: LayoutBuilder(
                  builder: (context, cons) {
                    var localH = cons.maxHeight;
                    var localW = cons.maxWidth;
                    return GetBuilder<LiveCourseDetailsCont>(
                      builder: (_) {
                        return ListView(
                          children: [
                            //TODO Image
                            SizedBox(
                                width: localW,
                                height: localH * 0.4,
                                child: Stack(
                                  children: [
                                    //TODO Image
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          width: localW,
                                          height: localH * 0.4,
                                          child:
                                              GetBuilder<LiveCourseDetailsCont>(
                                            builder: (_) {
                                              if (_courseDetailsCont
                                                      .courseDetailsResData
                                                      .image !=
                                                  null) {
                                                return ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          0.0),
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                    fit: BoxFit.fill,
                                                    imageScale: 1.0,
                                                    placeholder:
                                                        kTransparentImage,
                                                    image:
                                                        "${EndPoints.ImageUrl}${_courseDetailsCont.courseDetailsResData.image.toString()}",
                                                  ),
                                                );
                                              } else {
                                                return LogoContainer();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    ),

                                    //TODO Data On Image
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          color: Colors.black45,
                                          width: localW,
                                          height: localH * 0.4,
                                          padding: EdgeInsets.only(
                                              left: localW * 0.1),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [

                                              SizedBox(
                                                height: localH * 0.02,
                                              ),
                                              CustomText(
                                                txt: _courseDetailsCont
                                                            .courseDetailsResData
                                                            .name ==
                                                        null
                                                    ? ''
                                                    : _courseDetailsCont
                                                        .courseDetailsResData
                                                        .name,
                                                fontSize: localW * 0.07,
                                              ),
                                              SizedBox(
                                                height: localH * 0.02,
                                              ),
                                              CustomText(
                                                txt: _courseDetailsCont
                                                            .courseDetailsResData
                                                            .shortDescription ==
                                                        null
                                                    ? ''
                                                    : _courseDetailsCont
                                                        .courseDetailsResData
                                                        .shortDescription,
                                                fontSize: localW * 0.05,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                )),

                            //TODO buy Now
                            GetBuilder<LiveCourseDetailsCont>(builder: (_) {
                              //TODO owner == null or == false
                              if (_courseDetailsCont
                                          .courseDetailsResData.owner !=
                                      null &&
                                  !_courseDetailsCont
                                      .courseDetailsResData.owner) {
                                //TODO No Discount Price
                                if (_courseDetailsCont.courseDetailsResData
                                            .discountPrice ==
                                        null ||
                                    _courseDetailsCont.courseDetailsResData
                                            .discountPrice ==
                                        0) {
                                  return Container(
                                    width: localW,
                                    margin: EdgeInsets.only(
                                        left: localW * 0.03,
                                        right: localW * 0.03,
                                        top: localH * 0.01),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        //TODO price
                                        CustomText(
                                          txt: _courseDetailsCont
                                                      .courseDetailsResData
                                                      .price ==
                                                  null
                                              ? ''
                                              : _courseDetailsCont
                                                  .courseDetailsResData.price
                                                  .toString(),
                                          txtColor: ConstStyles.DarkColor,
                                        ),
                                        // CustomText(txt: 'EgyptianPound'.tr
                                        //   ,txtColor: ConstStyles.DarkColor,),
                                        SizedBox(
                                          width: localW * 0.03,
                                        ),

                                        GetBuilder<LiveCourseDetailsCont>(
                                            builder: (_) {
                                          return OrangeBtn(
                                            text: 'BuyNow'.tr,
                                            onClick: () async {
                                              //TODO User Not Logged In Can't buy
                                              if (_courseDetailsCont.getStorage
                                                          .read(LocalDataStrings
                                                              .isLogged) ==
                                                      null ||
                                                  !_courseDetailsCont.getStorage
                                                      .read(LocalDataStrings
                                                          .isLogged)) {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                        height: localH * 0.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              children: [
                                                                InkWell(
                                                                    onTap: () {
                                                                      Get.back();
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: ConstStyles
                                                                          .DarkColor,
                                                                    )),
                                                              ],
                                                            ),
                                                            //TODO Dialog Text
                                                            CustomText(
                                                              txt:
                                                                  "PleaseLoginFirst"
                                                                      .tr,
                                                              txtColor:
                                                                  ConstStyles
                                                                      .TextColor,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  localH * 0.04,
                                                            ),
                                                            OrangeBtn(
                                                                text:
                                                                    'SignIn'.tr,
                                                                onClick: () {
                                                                  Get.back();
                                                                  Get.toNamed(
                                                                      Login.Id);
                                                                }),
                                                            OrangeBtn(
                                                                text:
                                                                    'SignUp'.tr,
                                                                onClick: () {
                                                                  Get.back();
                                                                  Get.to(() =>
                                                                      Register());
                                                                }),
                                                          ],
                                                        ),
                                                      ));
                                                    });
                                              }
                                              //TODO User Already Logged In can buy
                                              else {
                                                var url = await _courseDetailsCont
                                                    .getPauPalLink(
                                                        _courseDetailsCont
                                                            .courseDetailsResData
                                                            .key,
                                                        _courseDetailsCont
                                                            .token);
                                                if (url != null) {
                                                  Get.to(() => PayPalView(url));
                                                }
                                              }
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                }
                                //TODO Discount price
                                else {
                                  return Container(
                                    width: localW,
                                    margin: EdgeInsets.only(
                                        left: localW * 0.03,
                                        right: localW * 0.03,
                                        top: localH * 0.01),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        SizedBox(
                                          width: localW * 0.2,
                                          height: localH * 0.05,
                                          child: Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Positioned.fill(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: SizedBox(
                                                    width: localW * 0.2,
                                                    child: CustomText(
                                                      txtAlign:
                                                          TextAlign.center,
                                                      txt: _courseDetailsCont
                                                                  .courseDetailsResData
                                                                  .price ==
                                                              null
                                                          ? ''
                                                          : _courseDetailsCont
                                                              .courseDetailsResData
                                                              .price
                                                              .toString(),
                                                      txtColor: Colors.green,
                                                      fontSize: localW * 0.05,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned.fill(
                                                  child: Align(
                                                alignment: Alignment.center,
                                                child: SizedBox(
                                                  width: localW * 0.15,
                                                  child: Divider(
                                                    thickness: 1,
                                                    color: Colors.green,
                                                  ),
                                                ),
                                              )),
                                            ],
                                          ),
                                        ),

                                        CustomText(
                                          txt: _courseDetailsCont
                                                      .courseDetailsResData
                                                      .discountPrice ==
                                                  null
                                              ? ''
                                              : _courseDetailsCont
                                                  .courseDetailsResData
                                                  .discountPrice
                                                  .toString(),
                                          txtColor: ConstStyles.DarkColor,
                                        ),
                                        // CustomText(txt: 'EgyptianPound'.tr
                                        //   ,txtColor: ConstStyles.DarkColor,),

                                        GetBuilder<LiveCourseDetailsCont>(
                                            builder: (_) {
                                          return OrangeBtn(
                                            text: 'BuyNow'.tr,
                                            onClick: () async {
                                              //TODO User Not Logged In Can't buy
                                              if (_courseDetailsCont.getStorage
                                                          .read(LocalDataStrings
                                                              .isLogged) ==
                                                      null ||
                                                  !_courseDetailsCont.getStorage
                                                      .read(LocalDataStrings
                                                          .isLogged)) {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                          content: Container(
                                                        height: localH * 0.3,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            //TODO Dialog Text
                                                            CustomText(
                                                              txt:
                                                                  "PleaseLoginFirst"
                                                                      .tr,
                                                              txtColor:
                                                                  ConstStyles
                                                                      .TextColor,
                                                            ),
                                                            SizedBox(
                                                              height:
                                                                  localH * 0.04,
                                                            ),
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                OrangeBtn(
                                                                    text:
                                                                        'SignIn'
                                                                            .tr,
                                                                    onClick:
                                                                        () {
                                                                      Get.back();
                                                                      Get.to(() =>
                                                                          Login());
                                                                    }),
                                                                OrangeBtn(
                                                                    text:
                                                                        'SignUp'
                                                                            .tr,
                                                                    onClick:
                                                                        () {
                                                                      Get.back();
                                                                      Get.to(() =>
                                                                          Register());
                                                                    }),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ));
                                                    });
                                              }
                                              //TODO User Already Logged In can buy
                                              else {
                                                var url = await _courseDetailsCont
                                                    .getPauPalLink(
                                                        _courseDetailsCont
                                                            .courseDetailsResData
                                                            .key,
                                                        _courseDetailsCont
                                                            .token);
                                                if (url != null) {
                                                  Get.to(() => PayPalView(url));
                                                }
                                              }
                                            },
                                          );
                                        }),
                                      ],
                                    ),
                                  );
                                }
                              }
                              //TODO owner == true
                              else {
                                return Container();
                              }
                            }),

                            //TODO Instructors
                            Container(
                              height: localH * 0.4,
                              width: localW,
                              color: ConstStyles.WhiteColor,
                              margin: EdgeInsets.only(
                                  left: localW * 0.04,
                                  right: localW * 0.04,
                                  top: localH * 0.02),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.center,
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // //TODO Instructor
                                  // Padding(
                                  //   padding:  EdgeInsets.only(left: localW * 0.01),
                                  //   child: CustomText(
                                  //     txt: 'Teachers'.tr,
                                  //     txtColor: ConstStyles.DarkColor,
                                  //     fontSize: localW * 0.07,
                                  //   ),
                                  // ),

                                  //TODO Teacher Image
                                  SizedBox(
                                    height: localH * 0.4,
                                    width: localW,
                                    child: GetBuilder<LiveCourseDetailsCont>(
                                        builder: (_) {
                                      if (_courseDetailsCont.dataOfCourseDes == null) {
                                        _courseDetailsCont.LiveCourseDesData();
                                      }

                                      if (_courseDetailsCont.dataOfCourseDes != null) {
                                        return Container(
                                          height: localH * 0.3,
                                          child: Column(
                                            children: [
                                              Container(
                                                height: localH * 0.13,
                                                width: localW * .8,
                                                child: Image(
                                                  image: NetworkImage("${EndPoints.ImageUrl}${_courseDetailsCont.dataOfCourseDes["data"]['image']}"),
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              // Row(
                                              //   children: [
                                              //     Container(
                                              //       padding: EdgeInsets.only(right: 10),
                                              //       height: localH * .09,
                                              //       child: ClipRRect(
                                              //         borderRadius: BorderRadius.circular(50),
                                              //         child: Image(
                                              //           image: NetworkImage("${EndPoints.ImageUrl}${_courseDetailsCont.dataOfCourseDes["data"]['teachers'][0]['image']}"),
                                              //           fit: BoxFit.contain,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //     SizedBox(width:10),
                                              //     CustomText(
                                              //       txt: _courseDetailsCont.dataOfCourseDes["data"]['teachers'][0]['name'],
                                              //       txtColor: ConstStyles.DarkColor,
                                              //       txtAlign: TextAlign.center,
                                              //     ),
                                              //   ],
                                              // ),
                                              Container(
                                                width: localW * .8,
                                                child: CustomText(
                                                  txt: "Lessons",
                                                  fontSize: 22,
                                                  txtColor: ConstStyles.DarkColor,
                                                  txtAlign: TextAlign.end,
                                                ),
                                              ),
                                              SizedBox(height:10),
                                              Container(
                                                height: localH * .15,
                                                width: localW *.8,
                                                child: ListView.builder(
                                                  itemCount: _courseDetailsCont.dataOfCourseDes["data"]['lessons'].length,
                                                  itemBuilder: (context,index){
                                                    return Column(
                                                      children: [
                                                        SizedBox(height:5),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                          children: [
                                                            CustomText(
                                                              txt:  _courseDetailsCont.dataOfCourseDes["data"]['lessons'][index]['name']??"",
                                                              txtColor: ConstStyles.DarkColor,
                                                              txtAlign: TextAlign.start,
                                                            ),
                                                            SizedBox(width:5),
                                                            Icon(Icons.done_sharp,color:Colors.green),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },

                                                )
                                              ),

                                            ],
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          height: localH * 0.3,
                                          decoration: BoxDecoration(),
                                          child: Icon(
                                            Icons.person,
                                            size: localH * 0.3,
                                          ),
                                          //image: NetworkImage("${EndPoints.ImageUrl}${_courseDetailsCont.courseDetailsResData.teacher.image}"),
                                        );
                                      }
                                    }),
                                  ),
                                ],
                              ),
                            ),

                            //TODO Course OverView
                            Container(
                              margin: EdgeInsets.only(
                                  left: localW * 0.04,
                                  right: localW * 0.04,
                                  bottom: localH * 0.01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    height: localH * 0.04,
                                  ),

                                  //TODO Course Overview
                                  Container(
                                    color: ConstStyles.WhiteColor,
                                    padding: EdgeInsets.only(
                                        top: localH * 0.03,
                                        bottom: localH * 0.01,
                                        left: localW * 0.01,
                                        right: localW * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                          txt: 'CourseOverView'.tr,
                                          txtColor: ConstStyles.DarkColor,
                                          fontSize: localW * 0.07,
                                        ),

                                        SizedBox(
                                          height: localH * 0.02,
                                        ),
                                        // AutoTextSize(text: _courseDetailsCont.courseDetailsResData.description == null ? ''
                                        //     : _courseDetailsCont.courseDetailsResData.description,
                                        //   size: localW * 0.05,),
                                        Html(
                                            data: _courseDetailsCont
                                                        .courseDetailsResData
                                                        .description ==
                                                    null
                                                ? ''
                                                : _courseDetailsCont
                                                    .courseDetailsResData
                                                    .description)
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: localH * 0.05,
                                  ),

                                  //TODO Requirements
                                  Container(
                                    width: localW,
                                    color: ConstStyles.WhiteColor,
                                    padding: EdgeInsets.only(
                                        top: localH * 0.03,
                                        bottom: localH * 0.01,
                                        left: localW * 0.01,
                                        right: localW * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                          txt: 'Requirements'.tr,
                                          txtColor: ConstStyles.DarkColor,
                                          fontSize: localW * 0.07,
                                        ),
                                        SizedBox(
                                          height: localH * 0.02,
                                        ),
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: localW * 0.1),
                                            child: Html(
                                              data: _courseDetailsCont
                                                          .courseDetailsResData
                                                          .requirements ==
                                                      null
                                                  ? ''
                                                  : _courseDetailsCont
                                                      .courseDetailsResData
                                                      .requirements,
                                            )
                                            /* AutoSizeText(_courseDetailsCont.courseDetailsResData.requirements == null ? ''
                                            : _courseDetailsCont.courseDetailsResData.requirements,
                                          textAlign: TextAlign.start ,
                                          style: TextStyle(
                                            fontSize: localW * 0.05,
                                            color:  ConstStyles.TextColor ,
                                            fontWeight: FontWeight.normal ,
                                          ),
                                          minFontSize: 8,
                                          stepGranularity: 1,
                                          // maxLines: 3,
                                        ),*/
                                            ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    height: localH * 0.05,
                                  ),

                                  //TODO What you will learn
                                  Container(
                                    width: localW,
                                    color: ConstStyles.WhiteColor,
                                    padding: EdgeInsets.only(
                                        top: localH * 0.03,
                                        bottom: localH * 0.01,
                                        left: localW * 0.01,
                                        right: localW * 0.01),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        CustomText(
                                          txt: 'WhatYouWillLearn'.tr,
                                          txtColor: ConstStyles.DarkColor,
                                          fontSize: localW * 0.07,
                                          txtAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: localH * 0.02,
                                        ),
                                        Html(
                                            data: _courseDetailsCont
                                                        .courseDetailsResData
                                                        .whatWillLearn ==
                                                    null
                                                ? ''
                                                : _courseDetailsCont
                                                    .courseDetailsResData
                                                    .whatWillLearn),
/*
                                      AutoSizeText(_courseDetailsCont.courseDetailsResData.whatWillLearn == null ? ''
                                          : _courseDetailsCont.courseDetailsResData.whatWillLearn,
                                        textAlign: TextAlign.start ,
                                        style: TextStyle(
                                          fontSize: localW * 0.05,
                                          color:  ConstStyles.TextColor ,
                                          fontWeight: FontWeight.normal ,
                                        ),
                                        minFontSize: 8,
                                        stepGranularity: 1,
                                      ),
*/
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //TODO Instructors
                            Container(
                              color: ConstStyles.WhiteColor,
                              margin: EdgeInsets.only(
                                  left: localW * 0.04,
                                  right: localW * 0.04,
                                  bottom: localH * 0.01),
                              height: localH * 0.3,
                              padding: EdgeInsets.only(
                                  left: localW * 0.01, right: localW * 0.01),
                              child: GetBuilder<LiveCourseDetailsCont>(
                                builder: (_) {
                                  if (_courseDetailsCont
                                              .courseDetailsResData.teachers !=
                                          null &&
                                      _courseDetailsCont.courseDetailsResData
                                              .teachers.length >
                                          0) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: localW * 0.01,
                                              top: localH * 0.005),
                                          height: localH * 0.05,
                                          child: CustomText(
                                            txt: 'Teachers'.tr,
                                            txtColor: ConstStyles.DarkColor,
                                            fontSize: localW * 0.07,
                                            txtAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: localH * 0.24,
                                          child: ListView.builder(
                                            itemCount: _courseDetailsCont
                                                .courseDetailsResData
                                                .teachers
                                                .length,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      //TODO Teacher Image
                                                      SizedBox(
                                                        height: localH * 0.1,
                                                        width: localW * 0.1,
                                                        child: GetBuilder<
                                                                LiveCourseDetailsCont>(
                                                            builder: (_) {
                                                          if (_courseDetailsCont
                                                                      .courseDetailsResData
                                                                      .teachers !=
                                                                  null &&
                                                              _courseDetailsCont
                                                                      .courseDetailsResData
                                                                      .teachers[
                                                                          index]
                                                                      .image !=
                                                                  null) {
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                  image: NetworkImage(
                                                                      "${EndPoints.ImageUrl}${_courseDetailsCont.courseDetailsResData.teachers[index].image}"),
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            );
                                                          } else {
                                                            return SizedBox(
                                                              width:
                                                                  localW * 0.25,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 50,
                                                                backgroundColor:
                                                                    ConstStyles
                                                                        .WhiteColor,
                                                                child:
                                                                    LogoContainer(),
                                                              ),
                                                            );
                                                          }
                                                        }),
                                                      ),

                                                      //TODO Teacher Name
                                                      SizedBox(
                                                        child: AutoTextSize(
                                                          text: _courseDetailsCont
                                                                      .courseDetailsResData
                                                                      .teachers[
                                                                          index]
                                                                      .name ==
                                                                  null
                                                              ? ''
                                                              : _courseDetailsCont
                                                                  .courseDetailsResData
                                                                  .teachers[
                                                                      index]
                                                                  .name,
                                                          textColor: ConstStyles
                                                              .BlackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),

                                                      //TODO Teacher Qualifications
                                                      SizedBox(
                                                        child: AutoTextSize(
                                                          text: _courseDetailsCont
                                                                      .courseDetailsResData
                                                                      .teachers[
                                                                          index]
                                                                      .qualifications ==
                                                                  null
                                                              ? ''
                                                              : _courseDetailsCont
                                                                  .courseDetailsResData
                                                                  .teachers[
                                                                      index]
                                                                  .qualifications,
                                                          textColor: ConstStyles
                                                              .BlackColor,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: Divider(
                                                      thickness: 2,
                                                      color: ConstStyles
                                                          .OrangeColor,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return LogoContainer();
                                  }
                                },
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
          },
        ),
      ),
    );
  }
}
