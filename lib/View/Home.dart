import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_transforms.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/Drawer/MainDrawerCont.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Controller/Profile/StudProfCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/Category/CategoryDataList.dart';
import 'package:troom/Models/Features/FeaturesDataList.dart';
import 'package:troom/Models/OurTeachers/OurTeachersDataList.dart';
import 'package:troom/Models/Slider/SliderDataList.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/Courses/AllCourses.dart';
import 'package:troom/View/Courses/PayPalView.dart';
import 'package:troom/View/LiveClasses/AllLiveCourses.dart';
import 'package:troom/View/Courses/CourseDetails.dart';
import 'package:troom/View/Courses/CourseListItem.dart';
import 'package:troom/View/LiveClasses/LiveCourseDetails.dart';
import 'package:troom/View/LiveClasses/LiveCourseListItem.dart';
import 'package:troom/View/LiveClasses/ReqPrivateCourse.dart';
import 'package:troom/View/MainDrawer.dart';
import 'package:troom/View/OurInstructors.dart';
import 'package:troom/View/PlacementTest.dart';
import 'package:video_player/video_player.dart';
import 'package:transparent_image/transparent_image.dart';

import 'StudentProfile/StudentProfile.dart';

class Home extends GetWidget<HomeCont> {
  static const Id = 'HomeScreen';
  String LOGD = 'HomeScreen';
  GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  StudProfCont _cont = Get.put(StudProfCont());

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var appBarH = AppBar().preferredSize.height;
    return GetBuilder<HomeCont>(
        init: Get.put(HomeCont()),
        builder: (_homeCont) {
          return Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(
              backgroundColor: Color(0xFFffc20e),
              actions: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [

                            CustomText(
                              txt: _cont.studProfResData.name == null
                                  ?"مرحبا بك في "
                                  :'مرحبا بك\n${_cont.studProfResData.name}'.tr,
                                txtColor: ConstStyles.BlackColor,
                              fontSize: 12,
                            )
                          ],
                        )

                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(
                      width: 40,
                      child: _cont.studProfResData.image != null ?GestureDetector(
                        onTap: (){
Navigator.push(context, MaterialPageRoute(builder: (_)=>StudentProfile()));
                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: EndPoints.ImageUrl + _cont
                                .studProfResData.image,
                          )
                      ) ,):   SizedBox(
                          width: width * 0.22,
                          height: appBarH,
                          child: Container(
                            child: LogoContainer(),
                          )
                      ),
                    ),
                  ],
                )
              ],
            ),
            drawer: GetBuilder<MainDrawerCont>(
              init: Get.put(MainDrawerCont()),
              builder: (_) {
                return MainDrawer();
              },),
            body: SafeArea(child: GetBuilder<ModalHudCont>(
              builder: (_) {
                return Container(
                  child: LayoutBuilder(
                    builder: (ctx, cons) {
                      var localW = cons.maxWidth;
                      var localH = cons.maxHeight;
                      return GetBuilder<HomeCont>(builder: (_) {
                        if (_homeCont.controller != null) {
                          if (_homeCont.controller.value.isPlaying) {
                            return Container(
                              width: width,
                              height: height,
                              color: ConstStyles.VideoColor,
                              child: Center(
                                child: FutureBuilder(
                                  future: _homeCont.initializeVideoPlayerFuture,
                                  builder: (context, snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      return AspectRatio(
                                          aspectRatio: _homeCont.controller
                                              .value.aspectRatio,
                                          child: VideoPlayer(
                                              _homeCont.controller));
                                    } else {
                                      return Center(
                                          child: CircularProgressIndicator()
                                      );
                                    }
                                  },
                                ),
                              ),
                            );
                          } else {
                            return ModalProgressHUD(
                              inAsyncCall: _homeCont.modalHudController
                                  .isLoading,
                              child: ListView(
                                children: [

                                  //TODO Slider
                                  Container(
                                    color: Color(0xFFffc20e),
                                    width: localW,
                                    height: localH * 0.33,
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: [
                                        //TODO Image
                                        Positioned.fill(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: SizedBox(
                                              width: localW,
                                              height: localH * 0.329,
                                              child: GetBuilder<HomeCont>(
                                                  builder: (_) {
                                                    return SizedBox(
                                                      width: localW,
                                                      height: localH * 0.329,
                                                      child: CarouselSlider
                                                          .builder(
                                                        unlimitedMode: true,
                                                        slideBuilder: (index) {
                                                          if (_homeCont
                                                              .sliderList
                                                              .length > 0) {
                                                            return slideWidget(
                                                                localW,
                                                                localH * 0.329,
                                                                _homeCont
                                                                    .sliderList[index]);
                                                          } else {
                                                            return SizedBox(
                                                                width: localW,
                                                                height: localH *
                                                                    0.3,
                                                                child: LogoContainer(
                                                                ));
                                                          }
                                                        },
                                                        slideTransform: StackTransform(),
                                                        enableAutoSlider: false,
                                                        autoSliderTransitionTime: Duration(
                                                            milliseconds: 5000),
                                                        itemCount: _homeCont
                                                            .sliderList != null
                                                            ? _homeCont
                                                            .sliderList.length
                                                            : 3,
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ),
                                        ),

//TODO Our Features

/*
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: localW,
                                    child: GetBuilder<HomeCont>(
                                      builder: (_){
                                        if (_homeCont.featureList.length > 0) {
                                          return SizedBox(
                                            height: localH * 0.07,
                                            width: localW ,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                //TODO slider item 1
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: ConstStyles.OrangeColor,
                                                    ),
                                                    child: featureListItem(localW * 0.33, localH * 0.1,_homeCont.featureList[0])),
                                                //TODO slider item 2
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: ConstStyles.DarkOrangeColor,
                                                    ),
                                                    child: featureListItem(localW * 0.33,
                                                        localH * 0.1,_homeCont.featureList[1])),
                                                //TODO slider item 3
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: ConstStyles.OrangeColor,
                                                    ),
                                                    child: featureListItem(localW * 0.33, localH * 0.1,_homeCont.featureList[2])),
                                              ],
                                            )
                                          );
                                        }
                                        else {
                                          return SizedBox(
                                              width: localW,
                                              height: localH * 0.07,
                                              child: LogoContainer(
                                                boxFit: BoxFit.fill,
                                                colors: ConstStyles.DarkColor,
                                              ));
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
*/
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: localH * 0.03,),

                                  //TODO Classes And Courses
                                  SizedBox(
                                    width: localW,
                                    height: localH * 0.35,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        SizedBox(width: localW * 0.05,),
                                        InkWell(
                                          onTap: () {
                                            // Get.back();
                                            Get.toNamed(AllCourses.Id);
                                          },
                                          child: SizedBox(
                                            height: localH * 0.35,
                                            width: localW * 0.4,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: ConstStyles
                                                              .BlackColor,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0xFFA89F9F),
                                                              blurRadius: 2.0,
                                                              spreadRadius: 1.0,
                                                              offset: Offset(
                                                                  2.0,
                                                                  2.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),

                                                        ),
                                                        child: Image(
                                                          image: AssetImage(
                                                            "assets/images/courses.jpg",
                                                          ),
                                                        ),
                                                        width: localW,
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      width: localW * 0.45,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF692a00)
                                                              .withOpacity(0.5),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                          // color: Colors.black38,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .end,
                                                          crossAxisAlignment: "AllRecordedCourses"
                                                              .tr ==
                                                              "AllRecordedCourses"
                                                              ? CrossAxisAlignment
                                                              .end
                                                              : CrossAxisAlignment
                                                              .start,
                                                          children: [
                                                            CustomText(
                                                              txt: 'AllRecordedCourses'
                                                                  .tr,
                                                              txtColor: ConstStyles
                                                                  .WhiteColor,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: localW *
                                                                  0.07,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: localW * 0.05,),

                                        InkWell(
                                          onTap: () {
                                            // Get.back();
                                            Get.toNamed(AllLiveCourses.Id);
                                          },
                                          child: SizedBox(
                                            height: localH * 0.35,
                                            width: localW * 0.4,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              // mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0xFFA89F9F),
                                                              blurRadius: 2.0,
                                                              spreadRadius: 1.0,
                                                              offset: Offset(
                                                                  2.0,
                                                                  2.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                          image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            // colorFilter: ColorFilter.mode(
                                                            //     Colors.transparent.withOpacity(0.6),
                                                            //     BlendMode.dstATop
                                                            // ),
                                                            image: AssetImage(
                                                              "assets/images/liveCourses.jpg",
                                                            ),
                                                          ),
                                                        ),
                                                        width: localW,
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      width: localW * 0.45,
                                                      child: Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5),
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF692a00)
                                                              .withOpacity(0.5),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                          // color: Colors.black38,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .end,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            Container(
                                                              width: localW *
                                                                  0.45,
                                                              child: CustomText(
                                                                txt: 'AllLiveClasses'
                                                                    .tr,
                                                                txtColor: ConstStyles
                                                                    .WhiteColor,
                                                                fontWeight: FontWeight
                                                                    .bold,
                                                                fontSize: localW *
                                                                    0.07,),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: localW * 0.05,),

                                        //TODO Private Courses
                                        InkWell(
                                          onTap: () {
                                            if (_homeCont.myToken == null) {
                                              Get.snackbar('', '',
                                                  backgroundColor: ConstStyles
                                                      .DarkColor,
                                                  colorText: ConstStyles
                                                      .WhiteColor,
                                                  titleText: CustomText(
                                                    txt: 'PleaseLoginFirst'.tr,
                                                    txtAlign: TextAlign
                                                        .center,));
                                            }
                                            //TODO Req Private Course
                                            else {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: _scaffoldkey
                                                      .currentState.context,
                                                  builder: (ctx) {
                                                    return GetBuilder<
                                                        ModalHudCont>(
                                                      builder: (_) {
                                                        return ModalProgressHUD(
                                                          inAsyncCall: _homeCont
                                                              .modalHudController
                                                              .isLoading,
                                                          child: GetBuilder<
                                                              HomeCont>(
                                                            builder: (_) {
                                                              //TODO Dialog
                                                              return AlertDialog(
                                                                content: ReqPrivateCourse(
                                                                  localH: localH *
                                                                      0.85,),
                                                              );
                                                            },),
                                                        );
                                                      },);
                                                  });
                                            }
                                          },
                                          child: SizedBox(
                                            width: localW * 0.4,
                                            height: localH * 0.35,
                                            child: Stack(
                                              fit: StackFit.expand,
                                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Color(
                                                                  0xFFA89F9F),
                                                              blurRadius: 2.0,
                                                              spreadRadius: 1.0,
                                                              offset: Offset(
                                                                  2.0,
                                                                  2.0), // shadow direction: bottom right
                                                            )
                                                          ],
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                          image: DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: AssetImage(
                                                              "assets/images/privateClasses.jpg",
                                                            ),
                                                          ),
                                                        ),
                                                        width: localW,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: SizedBox(
                                                      height: localH * 0.35,
                                                      width: localW * 0.45,
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: Color(
                                                              0xFF692a00)
                                                              .withOpacity(0.5),
                                                          borderRadius: BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  20.0)),
                                                          // color: Colors.black38,
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment
                                                              .end,
                                                          crossAxisAlignment: CrossAxisAlignment
                                                              .center,
                                                          children: [
                                                            CustomText(
                                                              txt: 'AllPrivateClasses'
                                                                  .tr,
                                                              txtColor: ConstStyles
                                                                  .WhiteColor,
                                                              fontWeight: FontWeight
                                                                  .bold,
                                                              fontSize: localW *
                                                                  0.07,),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: localW * 0.05,),

                                      ],
                                    ),
                                  ),

                                  SizedBox(
                                    width: localW,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        CustomText(
                                          txt: '.',
                                          txtColor: ConstStyles.BlackColor,
                                          fontSize: localW * 0.1,
                                        ),
                                        CustomText(
                                          txt: '.',
                                          txtColor: ConstStyles.BlackColor,
                                          fontSize: localW * 0.1,
                                        ),
                                        CustomText(
                                          txt: '.',
                                          txtColor: ConstStyles.BlackColor,
                                          fontSize: localW * 0.1,
                                        ),
                                      ],
                                    ),
                                  ),

                                  SizedBox(height: localH * 0.015,),

                                  Divider(
                                    thickness: 2,
                                    color: Colors.grey[350],
                                  ),

                                  //TODO Our courses
                                  Container(
                                    child: Column(
                                      children: [
                                        //TODO Our Courses
                                        SizedBox(
                                          width: localW,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.only(
                                                    right: localW * 0.05),
                                                child: CustomText(
                                                  txt: 'NewCourses'.tr,
                                                  fontSize: localW * 0.09,
                                                  txtColor: ConstStyles
                                                      .DarkColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),


                                        /*         //TODO Slider
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  //TODO Slider Views
                                  SizedBox(
                                    width: localW * 0.5,
                                    height: localH * 0.25,
                                    child: CarouselSlider.builder(
                                      unlimitedMode: true,
                                      slideBuilder: (index) {
                                        if ( _homeCont.categoriesList[index] != null &&
                                            _homeCont.categoriesList[index].image != null) {
                                          return SizedBox(
                                            width: localW * 0.5,
                                            height: localH * 0.25,
                                            child: categoryListItem(localW, localH ,
                                                _homeCont.categoriesList[index]),
                                          );
                                        } else {
                                          return SizedBox(
                                              width: localW * 0.5,
                                              height: localH * 0.15,
                                              child: LogoContainer(
                                              ));
                                        }
                                      },
                                      slideTransform: CubeTransform(),
                                      enableAutoSlider: true,
                                      autoSliderTransitionTime: Duration(milliseconds: 1000),
                                      itemCount:  _homeCont.categoriesList != null
                                          ? _homeCont.categoriesList.length
                                          : 0,
                                    ),
                                  ),


                                ],
                              ),*/


                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            //TODO Slider Views
                                            Container(
                                              // color: ConstStyles.DarkColor,
                                                width: localW,
                                                height: localH * 0.7,
                                                child: ListView.builder(
                                                  itemCount: _homeCont
                                                      .coursesList.length > 3
                                                      ? 3
                                                      : _homeCont.coursesList
                                                      .length,
                                                  itemBuilder: (context,
                                                      index) {
                                                    return GetBuilder<HomeCont>(
                                                        builder: (_) {
                                                          // print("sssssssssssssssss ${_homeCont.coursesList[index]}");

                                                          if (_homeCont
                                                              .coursesList[index] !=
                                                              null) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    CourseDetails(
                                                                        _homeCont
                                                                            .coursesList[index]
                                                                            .key));
                                                              },
                                                              child: CourseListItem(
                                                                  localH * 0.67,
                                                                  localW * 0.7,
                                                                  _homeCont
                                                                      .coursesList[index],
                                                                  "${'EgyptianPound'
                                                                      .tr}"),
                                                            );
                                                          } else {
                                                            return LogoContainer();
                                                          }
                                                        });
                                                  },
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  // children: [
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.coursesList[0] != null){
                                                  //       return InkWell(
                                                  //         onTap:(){
                                                  //           Get.to(()=> CourseDetails(_homeCont.coursesList[0].key));
                                                  //         },
                                                  //         child: CourseListItem(
                                                  //             localH * 0.67,
                                                  //             localW * 0.7,
                                                  //             _homeCont.coursesList[0],"${'EgyptianPound'.tr}"),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   },),
                                                  //
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.coursesList[1] != null){
                                                  //       return   InkWell(
                                                  //         onTap:(){
                                                  //           Get.to(()=> CourseDetails(_homeCont.coursesList[1].key));
                                                  //         },
                                                  //         child: CourseListItem(
                                                  //             localH * 0.67,
                                                  //             localW * 0.7,
                                                  //             _homeCont.coursesList[1],"${'EgyptianPound'.tr}"),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   },),
                                                  //
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.coursesList[2] != null){
                                                  //       return InkWell(
                                                  //         onTap:(){
                                                  //           Get.to(()=> CourseDetails(_homeCont.coursesList[2].key));
                                                  //         },
                                                  //         child: CourseListItem(
                                                  //             localH * 0.67,
                                                  //             localW * 0.7,
                                                  //             _homeCont.coursesList[2],"${'EgyptianPound'.tr}"),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   },),
                                                  //
                                                  // ],
                                                )
                                              // CarouselSlider.builder(
                                              //   unlimitedMode: true,
                                              //   slideBuilder: (index) {
                                              //     return InkWell(
                                              //       onTap:(){
                                              //         Get.to(()=> CourseDetails(_homeCont.coursesList[index].key));
                                              //       },
                                              //       child: CourseListItem(
                                              //           localH * 0.67,
                                              //           localW,
                                              //           _homeCont.coursesList[index],"${'EgyptianPound'.tr}"),
                                              //     );
                                              //   },
                                              //   slideTransform: CubeTransform(),
                                              //   autoSliderTransitionTime: Duration(milliseconds: 1000),
                                              //   itemCount:  _homeCont.coursesList.length >  3
                                              //       ? 3
                                              //       : _homeCont.coursesList.length,
                                              // ),
                                            ),

                                            SizedBox(
                                              width: localW,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),

                                        /*            //TODO Course Preview
                              SizedBox(
                                width: localW,
                                // height: localH * 0.7,
                                child: GetBuilder<HomeCont>(builder:(_){
                                  if (_homeCont.coursesList.length == 1) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                           Get.to(()=> CourseDetails(_homeCont.coursesList[0].key));
                                           },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[0],"${'EgyptianPound'.tr}"),
                                        ),
                                      ],
                                    );
                                  }
                                  else  if (_homeCont.coursesList.length == 2) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            Get.to(()=> CourseDetails(_homeCont.coursesList[0].key));
                                          },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[0],"${'EgyptianPound'.tr}"),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            Get.to(()=> CourseDetails(_homeCont.coursesList[1].key));
                                          },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[1],
                                              "${'EgyptianPound'.tr}"),
                                        ),
                                      ],
                                    );
                                  }
                                  else  if (_homeCont.coursesList.length >= 3) {
                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap:(){
                                            Get.to(()=> CourseDetails(_homeCont.coursesList[0].key));
                                          },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[0],
                                              "${'EgyptianPound'.tr}"),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            Get.to(()=> CourseDetails(_homeCont.coursesList[1].key));
                                          },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[1],
                                              "${'EgyptianPound'.tr}"),
                                        ),
                                        InkWell(
                                          onTap:(){
                                            Get.to(()=> CourseDetails(_homeCont.coursesList[2].key));
                                          },
                                          child: CourseListItem(
                                              localW,
                                              localH * 0.5,
                                              _homeCont.coursesList[2],
                                              "${'EgyptianPound'.tr}"),
                                        ),
                                      ],
                                    );
                                  }
                                  else {
                                    return SizedBox(
                                        width: localW,
                                        height: localH * 0.5,
                                        child: LogoContainer(
                                        ));
                                  }
                                }),
                              ),*/

                                      ],
                                    ),
                                  ),

                                  //TODO Placement Test
                                  Container(
                                    height: localH * 0.2,
                                    width: localW,
                                    margin: EdgeInsets.only(
                                        top: localH * 0.04,
                                        bottom: localH * 0.05),
                                    child: InkWell(
                                      onTap: () async {
                                        if (await _homeCont.getPalcementKey(
                                            _homeCont.myToken,
                                            _homeCont.appLang)) {
                                          showDialog(
                                              barrierDismissible: false,
                                              context: context,
                                              builder: (context) {
                                                return GetBuilder<ModalHudCont>(
                                                  builder: (_) {
                                                    return ModalProgressHUD(
                                                      inAsyncCall: _homeCont
                                                          .modalHudController
                                                          .isLoading,
                                                      child: GetBuilder<
                                                          HomeCont>(
                                                        builder: (_) {
                                                          //TODO Dialog
                                                          return AlertDialog(

                                                            content: PlacementTest(
                                                              localH: localH *
                                                                  0.85,),
                                                          );
                                                        },),
                                                    );
                                                  },);
                                              });
                                        } else {
                                          Get.snackbar('', '',
                                              backgroundColor: ConstStyles
                                                  .DarkColor,
                                              colorText: ConstStyles.WhiteColor,
                                              titleText: CustomText(
                                                txt: 'PleaseLoginFirst'.tr,
                                                txtAlign: TextAlign.center,));
                                        }
                                      },
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [

                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: localH * 0.2,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: ConstStyles
                                                        .BlackColor,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Color(
                                                            0xFFA89F9F),
                                                        blurRadius: 2.0,
                                                        spreadRadius: 1.0,
                                                        offset: Offset(2.0,
                                                            2.0), // shadow direction: bottom right
                                                      )
                                                    ],
                                                    // borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                    image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: AssetImage(
                                                        "assets/images/placement.jpg",
                                                      ),
                                                    ),
                                                  ),
                                                  width: localW,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                height: localH * 0.35,
                                                width: localW,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFF692a00)
                                                        .withOpacity(0.5),
                                                    borderRadius: BorderRadius
                                                        .all(
                                                        Radius.circular(20.0)),
                                                    // color: Colors.black38,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      CustomText(
                                                        txt: 'TestYourEnglishSkills'
                                                            .tr,
                                                        txtColor: ConstStyles
                                                            .WhiteColor,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: localW *
                                                            0.05,),
                                                      CustomText(
                                                        txt: 'TakePlacementTest'
                                                            .tr,
                                                        txtColor: ConstStyles
                                                            .WhiteColor,
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: localW *
                                                            0.05,),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

/*
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: localH * 0.1,
                                          width: localW,
                                          child: Center(
                                            child: OrangeBtn(
                                              text: 'TakePlacementTest'.tr,
                                              onClick: ()async{
                                                if(await _homeCont.getPalcementKey(_homeCont.myToken, _homeCont.appLang)){
                                                  showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context){
                                                        return GetBuilder<ModalHudCont>(builder: (_){
                                                          return ModalProgressHUD(
                                                            inAsyncCall: _homeCont.modalHudController.isLoading,
                                                            child: GetBuilder<HomeCont>(builder: (_){
                                                              //TODO Dialog
                                                              return AlertDialog(

                                                                content: PlacementTest(localH: localH * 0.85,),
                                                              );
                                                            },),
                                                          );
                                                        },);
                                                      });
                                                }else{
                                                  Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                      colorText: ConstStyles.WhiteColor,
                                                      titleText: CustomText(txt: 'PleaseLoginFirst'.tr,
                                                        txtAlign: TextAlign.center,));
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
*/
                                        ],
                                      ),
                                    ),
                                  ),

                                  //TODO Analysis
                                  /*   Container(
                              height: localH * 0.35,
                              width: localW ,
                              margin: EdgeInsets.only(
                                  top: localH * 0.04, bottom: localH * 0.05),
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: localH * 0.35,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFFF0F0F0),
                                            // image: DecorationImage(
                                            //   fit: BoxFit.fill,
                                            //   colorFilter: ColorFilter.mode(
                                            //       Colors.black.withOpacity(0.6),
                                            //       BlendMode.dstATop),
                                            //   image: AssetImage(
                                            //     "assets/images/logo.png",
                                            //   ),
                                            // ),
                                          ),
                                          width: localW,
                                        ),
                                      ),
                                    ),
                                  ),

                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        height: localH * 0.35,
                                        width: localW,
                                        child: Container(
                                          // color: Colors.black38,
                                          child: SizedBox(
                                            width: localW * 0.25,
                                            height: localH * 0.35,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    analysis(localW * 0.4, localH * 0.3,_homeCont.analysisData.courses,'Course'.tr),
                                                    analysis(localW * 0.4, localH * 0.3,_homeCont.analysisData.classes,'Class'.tr),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: [
                                                    analysis(localW * 0.4, localH * 0.3,_homeCont.analysisData.teachers,'Teacher'.tr),
                                                    analysis(localW * 0.4, localH * 0.3,_homeCont.analysisData.strudents,'Student'.tr),
                                                  ],
                                                ),
                                              ],
                                            ),),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),*/

                                  //TODO Upcoming Live Courses
                                  Container(
                                    // margin: EdgeInsets.only(
                                    //     top: localH * 0.04, bottom: localH * 0.05),
                                    child: Column(
                                      children: [
                                        //TODO Upcoming Live Classes
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: localW * 0.05),
                                          width: localW,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            children: [
                                              SizedBox(
                                                child: AutoTextSize(
                                                  text: 'UpComingLiveClasses'
                                                      .tr,
                                                  size: localW * 0.07,
                                                  textColor: ConstStyles
                                                      .DarkColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        AllLiveCourses()));
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment
                                                .center,
                                            children: [
                                              SizedBox(width: 10,),
                                              Icon(
                                                Icons.double_arrow,
                                                color: Colors.green,
                                              ),

                                              SizedBox(
                                                // width: localW * 0.2,
                                                child: AutoTextSize(
                                                  text: 'More'.tr,
                                                  textColor:
                                                  Colors.green,
                                                  size:
                                                  localW * 0.05,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                        ,
                                        //TODO Live Classes Preview
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            //TODO Slider Views
                                            Container(
                                              // color: ConstStyles.DarkColor,
                                                width: localW,
                                                height: localH * 0.7,
                                                child: ListView.builder(
                                                  scrollDirection: Axis
                                                      .horizontal,
                                                  itemCount: _homeCont
                                                      .liveCoursesList.length >
                                                      3 ? 3 : _homeCont
                                                      .liveCoursesList.length,
                                                  itemBuilder: (context,
                                                      index) {
                                                    return GetBuilder<HomeCont>(
                                                        builder: (_) {
                                                          if (_homeCont
                                                              .liveCoursesList[index] !=
                                                              null) {
                                                            return InkWell(
                                                              onTap: () {
                                                                Get.to(() =>
                                                                    LiveCourseDetails(
                                                                        _homeCont
                                                                            .liveCoursesList[index]
                                                                            .key));
                                                              },
                                                              child: LiveCourseListItem(
                                                                  localH * 0.67,
                                                                  localW * 0.7,
                                                                  _homeCont
                                                                      .liveCoursesList[index],
                                                                  'EgyptianPound'
                                                                      .tr,
                                                                  'More'.tr),
                                                            );
                                                          } else {
                                                            return LogoContainer();
                                                          }
                                                        });
                                                  },
                                                  // children: [
                                                  //
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.liveCoursesList[0]!= null){
                                                  //       return InkWell(
                                                  //         onTap: (){
                                                  //           Get.to( LiveCourseDetails(_homeCont.liveCoursesList[0].key));
                                                  //         },
                                                  //         child: LiveCourseListItem(localH * 0.67, localW * 0.7, _homeCont.liveCoursesList[0],'EgyptianPound'.tr,
                                                  //             'More'.tr),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   }),
                                                  //
                                                  //
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.liveCoursesList[0]!= null){
                                                  //       return InkWell(
                                                  //         onTap: (){
                                                  //           Get.to( LiveCourseDetails(_homeCont.liveCoursesList[1].key));
                                                  //         },
                                                  //         child: LiveCourseListItem(localH * 0.67, localW * 0.7, _homeCont.liveCoursesList[1],'EgyptianPound'.tr,
                                                  //             'More'.tr),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   }),
                                                  //
                                                  //
                                                  //   GetBuilder<HomeCont>(builder: (_){
                                                  //     if(_homeCont.liveCoursesList[0]!= null){
                                                  //       return InkWell(
                                                  //         onTap: (){
                                                  //           Get.to( LiveCourseDetails(_homeCont.liveCoursesList[2].key));
                                                  //         },
                                                  //         child: LiveCourseListItem(localH * 0.67, localW * 0.7, _homeCont.liveCoursesList[2],'EgyptianPound'.tr,
                                                  //             'More'.tr),
                                                  //       );
                                                  //     }else{
                                                  //       return LogoContainer();
                                                  //     }
                                                  //   }),
                                                  //
                                                  // ],
                                                )
                                              // CarouselSlider.builder(
                                              //   unlimitedMode: true,
                                              //   slideBuilder: (index) {
                                              //     return InkWell(
                                              //       onTap:(){
                                              //         Get.to(()=> CourseDetails(_homeCont.coursesList[index].key));
                                              //       },
                                              //       child: CourseListItem(
                                              //           localH * 0.67,
                                              //           localW,
                                              //           _homeCont.coursesList[index],"${'EgyptianPound'.tr}"),
                                              //     );
                                              //   },
                                              //   slideTransform: CubeTransform(),
                                              //   autoSliderTransitionTime: Duration(milliseconds: 1000),
                                              //   itemCount:  _homeCont.coursesList.length >  3
                                              //       ? 3
                                              //       : _homeCont.coursesList.length,
                                              // ),
                                            ),

                                            SizedBox(
                                              width: localW,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment
                                                    .center,
                                                children: [
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                  CustomText(
                                                    txt: '.',
                                                    txtColor: ConstStyles
                                                        .BlackColor,
                                                    fontSize: localW * 0.1,
                                                  ),
                                                ],
                                              ),
                                            ),

                                          ],
                                        ),
/*
                              SizedBox(
                                width: localW,
                                child: GetBuilder<HomeCont>(builder: (_){
                                  if(_homeCont.liveCoursesList.length > 3){
                                    return Column(
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              Get.to( LiveCourseDetails(_homeCont.liveCoursesList[0].key));
                                            },
                                            child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[0],'EgyptianPound'.tr,
                                                'More'.tr),
                                            ),

                                        InkWell(
                                            onTap: (){
                                              Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[1].key));
                                            },
                                            child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[1],'EgyptianPound'.tr,
                                            'More'.tr)),

                                        InkWell(
                                            onTap: (){
                                              Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[2].key));
                                            },
                                            child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[2],"${'EgyptianPound'.tr}",
                                                "${'More'.tr}")),
                                      ],
                                    );
                                  }else if(_homeCont.liveCoursesList.length == 1){
                                    return InkWell(
                                        onTap: (){
                                          Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[0].key));
                                        },
                                        child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[0],'EgyptianPound'.tr,
                                            'More'.tr));
                                  }
                                  else if(_homeCont.liveCoursesList.length == 2){
                                    return Column(
                                      children: [
                                        InkWell(
                                            onTap: (){
                                              Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[0].key));
                                            },
                                            child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[0],'EgyptianPound'.tr,
                                                'More'.tr)),

                                        InkWell(
                                            onTap: (){
                                              Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[1].key));
                                            },
                                            child: LiveCourseListItem(localW, localH * 0.7, _homeCont.liveCoursesList[1],'EgyptianPound'.tr,
                                                'More'.tr)),
                                      ],
                                    );
                                  }
                                  else{
                                    return SizedBox(
                                        width: localW,
                                        height: localH * 0.5,
                                        child: LogoContainer(
                                        ));
                                  }
                                },)
                              ),
*/

/*
                                  OrangeBtn(text: 'AllLiveClasses'.tr, onClick: () {
                                    Get.back();
                                    Get.toNamed(AllLiveCourses.Id);
                                  }),
*/
                                      ],
                                    ),
                                  ),


                                  //TODO our instructor
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (_) =>
                                                OurInstructor()));
                                      },
                                      child: Container(
                                        // color: Color(0xFFF3EAEA),
                                        margin: EdgeInsets.only(
                                            top: localH * 0.04,
                                            bottom: localH * 0.05),
                                        child: Column(
                                          children: [
                                            //TODO Our instructor
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              children: [
                                                CustomText(
                                                  txt: 'Teachers'.tr,
                                                  fontSize: localW * 0.09,
                                                  txtColor: ConstStyles
                                                      .OrangeColor,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  right: localW * 0.25,
                                                  left: localW * 0.25),
                                              child: Divider(
                                                thickness: 5,
                                                color: ConstStyles.OrangeColor,
                                              ),
                                            ),

                                            SizedBox(
                                              height: localH * 0.05,
                                            ),

                                            //TODO Slider
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                              children: [
                                                //TODO Slider Views
                                                SizedBox(
                                                    width: localW * 0.75,
                                                    height: localH * 0.3,
                                                    child:
                                                    CarouselSlider.builder(
                                                      unlimitedMode: true,
                                                      slideBuilder: (index) {
                                                        if (_homeCont
                                                            .ourTeachersList
                                                            .length > 0) {
                                                          return Container(
                                                            decoration: BoxDecoration(
                                                              color: ConstStyles
                                                                  .WhiteColor,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey[600],
                                                                  blurRadius: 2.0,
                                                                  // spreadRadius: 1.0,
                                                                  offset: Offset(
                                                                      2.0,
                                                                      2.0), // shadow direction: bottom right
                                                                )
                                                              ],
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                  .circular(
                                                                  10.0)),
                                                            ),
                                                            width: localW * 0.5,
                                                            height: localH *
                                                                0.3,
                                                            child: ourTeacherListItem(
                                                                localW * 0.59,
                                                                localH,
                                                                _homeCont
                                                                    .ourTeachersList[index]),
                                                          );
                                                        } else {
                                                          return SizedBox(
                                                              width: localW *
                                                                  0.73,
                                                              height: localH *
                                                                  0.25,
                                                              child: LogoContainer());
                                                        }
                                                      },
                                                      slideTransform: CubeTransform(),
                                                      enableAutoSlider: true,
                                                      autoSliderTransitionTime: Duration(
                                                          milliseconds: 1000),
                                                      itemCount: _homeCont
                                                          .ourTeachersList !=
                                                          null
                                                          ? _homeCont
                                                          .ourTeachersList
                                                          .length
                                                          : 3,
                                                    )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),

                                ],
                              ),
                            );
                          }
                        } else {
                          return ModalProgressHUD(
                            inAsyncCall: true,
                            child: Container(),
                          );
                        }
                      });
                    },
                  ),
                );
              },
            ),),
          );
        });
  }

  //TODO Slider Widgets Data
  Widget slideWidget(localW, localH, SliderDataList item) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //TODO Image
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: localH * 0.98,
              width: localW,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  //TODO Image
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        height: localH * 0.98,
                        child:


                        CachedNetworkImage(
                          imageUrl: EndPoints.ImageUrl + item.image.toString(),
                          imageBuilder: (context, imageProvider) {
                            if (item.image != null) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                    colorFilter:
                                    ColorFilter.mode(
                                        Colors.black.withOpacity(1),
                                        BlendMode.dstATop),),
                                ),
                              );
                            } else {
                              return LogoContainer();
                            }
                          },

                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
/*
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(1), BlendMode.dstATop),
                              image: NetworkImage(
                                  EndPoints.ImageUrl + item.image.toString()),
                            ),
                          ),
                          width: localW,
                          // height: localH * 0.4,
                        ),
                        */
                      ),
                    ),
                  ),

                  //TODO Description Text
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: localW,
                        height: localH,
                        child: Container(
                          height: localH,
                          decoration: BoxDecoration(
                              color: Color(0xFF692a00).withOpacity(0.5)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: localW * 0.04, right: localW * 0.04),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  txt: item.name,
                                  txtColor: ConstStyles.WhiteColor,
                                  fontSize: localW * 0.065,
                                  txtAlign: TextAlign.start,
                                ),
                                SizedBox(height: localH * 0.01,),
                                CustomText(
                                  txt: item.paragraph,
                                  txtColor: ConstStyles.WhiteColor,
                                  fontSize: localW * 0.035,
                                  txtAlign: TextAlign.start,
                                ),
                                SizedBox(height: localH * 0.01,),

                                GetBuilder<HomeCont>(builder: (_) {
                                  if (item.btnUrl != null) {
                                    return SizedBox(
                                      height: localH * 0.07,
                                      child: OrangeBtn(
                                        text: 'More'.tr,
                                        onClick: () {
                                          print(item.btnUrl);
                                          if (item.btnUrl ==
                                              'https://education.aisent.net/') {
                                            Get.back();
                                            Get.offAllNamed(Home.Id);
                                          } else {
                                            Get.to(() =>
                                                PayPalView(item.btnUrl));
                                          }
                                        },
                                        fontSize: 10,
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                }),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

      ],
    );
  }


  //TODO Features List Item
  Widget featureListItem(localW, localH, FeaturesDataList item) {
    return SizedBox(
      width: localW,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //TODO Image
          SizedBox(
            width: localW * 0.09,
            child: CircleAvatar(
              backgroundColor: ConstStyles.WhiteColor,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:
                    NetworkImage(EndPoints.ImageUrl +
                        item.image.toString().replaceAll(RegExp(' '), '%20')),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: localW * 0.01,
          ),

          SizedBox(
            width: localW * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    width: localW,
                    child: CustomText(
                      txt: item.name,
                      txtColor: ConstStyles.DarkColor,
                      fontSize: localW * 0.02,
                    )),
                SizedBox(
                    width: localW,
                    child: CustomText(
                      txt:
                      item.description,
                      txtColor: ConstStyles.DarkColor,
                      fontSize: localW * 0.002,
                      fontWeight: FontWeight.normal,
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  //TODO Categories List Item
  Widget categoryListItem(localW, localH, CategoryDataList item) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.center,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Container(
          width: localW * 0.3,
          height: localH * 0.15,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  EndPoints.ImageUrl + item.image.toString()),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
            width: localW * 0.3,
            height: localH * 0.05,
            child: Center(
                child: CustomText(
                  txt: item.name,
                  txtColor: ConstStyles
                      .BlackColor,
                  fontSize: localW * 0.05,
                  fontWeight:
                  FontWeight.normal,
                ))),
      ],
    );
  }

  //TODO Our Teacher List Item
  Widget ourTeacherListItem(localW, localH, OurTeachersDataList item) {
    return Column(
      mainAxisAlignment:
      MainAxisAlignment.spaceAround,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: [
        Container(
          width: localW,
          height: localH * 0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(EndPoints.ImageUrl + item.image.toString()),
              fit: BoxFit.fill,
            ),
          ),
        ),

        CustomText(
          txt: item.name,
          txtColor: ConstStyles.TextColor,
          fontSize: localW * 0.06,
        ),
      ],
    );
  }

  Widget analysis(localW, localH, num, txt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomText(
          txt: num.toString(),
          txtColor: ConstStyles.TextColor,
          fontSize: localW * 0.45,
        ),
        Container(
          width: localW * 0.4,
          child: Divider(
            thickness: 3,
            color: ConstStyles.DarkColor,
          ),
        ),
        CustomText(
          txt: txt,
          txtColor: ConstStyles.TextColor,
        ),
      ],
    );
  }

}
