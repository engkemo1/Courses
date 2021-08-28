import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Controller/Profile/StudProfCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomNetworkImage.dart';
import 'package:troom/CustomViews/CustomProfForm.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyCourses/MyCoursesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyPrivateClasses/MyPrivateClassesDataList.dart';
import 'package:troom/Models/Profile/StudentProfile/MyProfile/EditStudProfReq.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/Util/LocalDataStrings.dart';
import 'package:troom/View/Courses/CourseDetails.dart';
import 'package:troom/View/MainDrawer.dart';

class StudentProfile extends GetView<StudProfCont> {
  static const Id = 'StudentProfileScreen';
  StudProfCont _cont = Get.put(StudProfCont());
  var _formKey = GlobalKey<FormState>();
  String LOGD = 'StudentProfileView--->';

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
              inAsyncCall: _cont.modalHudController.isLoading,
              child: GetBuilder<StudProfCont>(
                builder: (_) {
                  return Container(child: LayoutBuilder(
                    builder: (context, cons) {
                      var localW = cons.maxWidth;
                      var localH = cons.maxHeight;
                      return GetBuilder<StudProfCont>(builder: (_) {
                        return ListView(
                          children: [
                            //TODO Bar
                            Container(
                              height: localH * .35,
                              width: localW,
                              padding: EdgeInsets.only(
                                  top: localH * 0.01, left: 20, right: 20),
                              color: ConstStyles.DarkColor,
                              child: Column(
                                children: [
                                  //TODO Profile Image
                                  SizedBox(
                                    width: localW * 0.25,
                                    child: _cont.studProfResData.image != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: FadeInImage.memoryNetwork(
                                              placeholder: kTransparentImage,
                                              image: EndPoints.ImageUrl +
                                                  _cont.studProfResData.image,
                                            ))
                                        : SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.30,
                                            height: appBarH,
                                            child: Container(
                                              child: LogoContainer(),
                                            )),
                                  ),
                                  SizedBox(
                                    height: localH * 0.02,
                                  ),

                                  //TODO User Name
                                  CustomText(
                                    txt: _cont.studProfResData.name == null
                                        ? ''
                                        : _cont.studProfResData.name,
                                  ),

                                  SizedBox(
                                    height: localH * 0.04,
                                  ),

                                  //TODO My profile

                                  Container(
                                    padding: EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _cont.changeView(
                                                    LocalDataStrings.MyProfile);
                                              },
                                              child: Icon(
                                                Icons.person,
                                                color: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyProfile
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                              ),
                                            ),
                                            CustomText(
                                                txt: 'MyProfileData'.tr,
                                                txtColor: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyProfile
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                                fontSize: 12),
                                          ],
                                        )),
                                        //TODO My Courses
                                        Container(
                                            child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _cont.changeView(
                                                    LocalDataStrings.MyCourses);
                                              },
                                              child: Icon(
                                                Icons.dvr,
                                                color: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyCourses
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                              ),
                                            ),
                                            CustomText(
                                              txt: 'MyCourses'.tr,
                                              txtColor: _cont.showView ==
                                                      LocalDataStrings.MyCourses
                                                  ? ConstStyles.OrangeColor
                                                  : ConstStyles.TextColor,
                                              fontSize: 12,
                                            ),
                                          ],
                                        )),

                                        //TODO My Classes
                                        Container(
                                            child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _cont.changeView(
                                                    LocalDataStrings.MyClasses);
                                              },
                                              child: Icon(
                                                Icons.live_tv,
                                                color: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyClasses
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                              ),
                                            ),
                                            CustomText(
                                                txt: 'MyClasses'.tr,
                                                txtColor: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyClasses
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                                fontSize: 12),
                                          ],
                                        )),

                                        //TODO My Private Classes
                                        Container(
                                            child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                _cont.changeView(
                                                    LocalDataStrings
                                                        .MyPrivateClasses);
                                              },
                                              child: Icon(
                                                Icons.live_tv,
                                                color: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyPrivateClasses
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                              ),
                                            ),
                                            CustomText(
                                                txt: 'MyPrivateClasses'.tr,
                                                txtColor: _cont.showView ==
                                                        LocalDataStrings
                                                            .MyPrivateClasses
                                                    ? ConstStyles.OrangeColor
                                                    : ConstStyles.TextColor,
                                                fontSize: 12),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //TODO Profile Data
                            Container(
                              margin: EdgeInsets.only(
                                  left: localW * 0.1,
                                  right: localW * 0.1,
                                  top: localH * 0.05,
                                  bottom: localH * 0.1),
                              padding: EdgeInsets.only(
                                  left: localW * 0.05, top: localH * 0.05),
                              color: ConstStyles.WhiteColor,
                              child: GetBuilder<StudProfCont>(
                                builder: (_) {
                                  //TODO Student Profile Data

                                  //TODO My Courses
                                  if (_cont.showView ==
                                      LocalDataStrings.MyCourses) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          txtColor: ConstStyles.BlackColor,
                                          txt: 'Courses'.tr,
                                          fontSize: localW * 0.06,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: ConstStyles.BlackColor,
                                        ),
                                        SizedBox(
                                          height: localH * 0.03,
                                        ),
                                        SizedBox(
                                          width: localW,
                                          height: localH * 0.6,
                                          child: ListView.builder(
                                            itemCount: _cont.coursesList != null
                                                ? _cont.coursesList.length
                                                : 0,
                                            itemBuilder: (context, index) {
                                              if (_cont.coursesList.length >
                                                  0) {
                                                return InkWell(
                                                    onTap: () {
                                                      Get.to(() =>
                                                          CourseDetails(_cont
                                                              .coursesList[
                                                                  index]
                                                              .key));
                                                    },
                                                    child: myCoursesItem(
                                                        localH * 0.6,
                                                        localW,
                                                        _cont.coursesList[
                                                            index]));
                                              } else {
                                                return SizedBox(
                                                  width: localW,
                                                  height: localH * 0.6,
                                                  child: LogoContainer(),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  else if (_cont.showView ==
                                      LocalDataStrings.MyProfile) {
                                    return profileData(localH, localW);
                                  }
                                  //TODO My Classes
                                  else if (_cont.showView ==
                                      LocalDataStrings.MyClasses) {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoTextSize(
                                          textColor: ConstStyles.BlackColor,
                                          text: 'Classes'.tr,
                                          fontWeight: FontWeight.bold,
                                          size: localW * 0.06,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: ConstStyles.BlackColor,
                                        ),
                                        SizedBox(
                                          height: localH * 0.015,
                                        ),
                                        SizedBox(
                                          width: localW,
                                          height: localH * 0.33,
                                          child: ListView.builder(
                                              itemCount:
                                                  _cont.classesList != null
                                                      ? _cont.classesList.length
                                                      : 0,
                                              itemBuilder: (context, index) {
                                                if (_cont.classesList.length >
                                                    0) {
                                                  return myClassesItem(
                                                      localH * 0.6,
                                                      localW,
                                                      _cont.classesList[index]);
                                                } else {
                                                  return SizedBox(
                                                    width: localW,
                                                    height: localH * 0.6,
                                                    child: LogoContainer(),
                                                  );
                                                }
                                              }),
                                        )
                                      ],
                                    );
                                  }
                                  //TODO Private Classes
                                  else {
                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoTextSize(
                                          textColor: ConstStyles.BlackColor,
                                          text: 'MyPrivateClasses'.tr,
                                          fontWeight: FontWeight.bold,
                                          size: localW * 0.06,
                                        ),
                                        Divider(
                                          thickness: 1,
                                          color: ConstStyles.BlackColor,
                                        ),
                                        SizedBox(
                                          height: localH * 0.015,
                                        ),
                                        SizedBox(
                                          width: localW,
                                          height: localH * 0.33,
                                          child: ListView.builder(
                                              itemCount:
                                                  _cont.privateClassesList !=
                                                          null
                                                      ? _cont.privateClassesList
                                                          .length
                                                      : 0,
                                              itemBuilder: (context, index) {
                                                if (_cont.privateClassesList
                                                        .length >
                                                    0) {
                                                  return myPrivateClassesItem(
                                                      localH * 0.6,
                                                      localW,
                                                      _cont.privateClassesList[
                                                          index]);
                                                } else {
                                                  return SizedBox(
                                                    width: localW,
                                                    height: localH * 0.6,
                                                    child: LogoContainer(),
                                                  );
                                                }
                                              }),
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            )
                          ],
                        );
                      });
                    },
                  ));
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget profileData(localH, localW) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            txtColor: ConstStyles.BlackColor,
            txt: 'EditProfileData'.tr,
            fontSize: localW * 0.06,
          ),
          Divider(
            thickness: 1,
            color: ConstStyles.BlackColor,
          ),
          SizedBox(
            height: localH * 0.03,
          ),

          //TODO Name
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.name == null
                    ? _cont.studProfResData.name
                    : _cont.name),
            obscureText: false,
            keybord: TextInputType.text,
            onChange: (v) {
              _cont.name = v;
            },
            onSave: (v) {
              _cont.name = v;
            },
          ),

          SizedBox(
            height: localH * 0.02,
          ),

          //TODO Email
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.email == null
                    ? _cont.studProfResData.email
                    : _cont.email),
            obscureText: false,
            keybord: TextInputType.text,
            onSave: (v) {
              _cont.email = v;
            },
            onChange: (v) {
              _cont.email = v;
            },
          ),

          SizedBox(
            height: localH * 0.02,
          ),

          //TODO Phone
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.phone == null
                    ? _cont.studProfResData.phone
                    : _cont.phone.toString()),
            obscureText: false,
            keybord: TextInputType.number,
            onSave: (v) {
              _cont.phone = v;
            },
            onChange: (v) {
              _cont.phone = v;
            },
          ),

          SizedBox(
            height: localH * 0.02,
          ),

          //TODO old Password
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.oldPassword == null ? null : _cont.oldPassword),
            hint: 'Old Password',
            hintColor: ConstStyles.TextColor,
            obscureText: true,
            keybord: TextInputType.text,
            onSave: (v) {
              _cont.oldPassword = v;
            },
            onChange: (v) {
              _cont.oldPassword = v;
            },
          ),

          SizedBox(
            height: localH * 0.02,
          ),

          //TODO New Password
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.newPassword == null ? null : _cont.newPassword),
            hint: 'New Password',
            obscureText: true,
            keybord: TextInputType.text,
            onSave: (v) {
              _cont.newPassword = v;
            },
            onChange: (v) {
              _cont.newPassword = v;
            },
          ),

          SizedBox(
            height: localH * 0.02,
          ),

          //TODO new confirm Password
          CustomProfForm(
            myController: TextEditingController(
                text: _cont.newPassword == null ? null : _cont.newPassword),
            hint: 'New Password Confirmation',
            obscureText: true,
            keybord: TextInputType.text,
            onSave: (v) {
              _cont.newConfPass = v;
            },
            onChange: (v) {
              _cont.newConfPass = v;
            },
          ),

          OrangeBtn(
            btnColor: ConstStyles.BlueColor,
            text: 'Edit'.tr,
            onClick: () async {
              _formKey.currentState.save();
              _cont.editStudProfReq = EditStudProfReq(
                  _cont.name,
                  _cont.email,
                  _cont.oldPassword,
                  _cont.newPassword,
                  _cont.phone,
                  _cont.newConfPass);
              print('$LOGD Edit Btn ::: ${_cont.listErrorMessage.length}');
              if (await _cont.editMainProfileData(_cont.editStudProfReq)) {
                Get.snackbar('', '',
                    backgroundColor: ConstStyles.DarkColor,
                    colorText: ConstStyles.WhiteColor,
                    titleText: CustomText(
                      txt: 'DataUpdatedSuccessfully'.tr,
                      txtAlign: TextAlign.center,
                    ));
                _cont.getMainProfData(_cont.token);
              } else {
                Get.snackbar('', '',
                    backgroundColor: ConstStyles.DarkColor,
                    colorText: ConstStyles.WhiteColor,
                    titleText: CustomText(
                      txt: _cont.listErrorMessage[0],
                      txtAlign: TextAlign.center,
                    ));
              }
            },
          ),
        ],
      ),
    );
  }

  Widget myCoursesItem(localH, localW, MyCoursesDataList item) {
    return Container(
      margin: EdgeInsets.only(bottom: localH * 0.02),
      height: localH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: localW,
            height: localH * 0.35,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(EndPoints.ImageUrl + item.image.toString()),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: localH * 0.02,
          ),
          Container(
            height: localH * 0.46,
            width: localW,
            padding: EdgeInsets.only(left: localW * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: localH * 0.06,
                    child: AutoTextSize(
                      text: item.name,
                      textColor: ConstStyles.BlackColor,
                      size: localW * 0.06,
                      fontWeight: FontWeight.bold,
                    )),

                SizedBox(
                    height: localH * 0.18,
                    child: AutoTextSize(
                      text: item.shortDescription,
                      textColor: ConstStyles.BlackColor,
                      size: localW * 0.038,
                    )),

                Container(
                  width: localW,
                  height: localH * 0.06,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GetBuilder<StudProfCont>(builder: (_) {
                        if (item.discountPrice == 0 ||
                            item.discountPrice == null) {
                          return Container();
                        } else {
                          return SizedBox(
                            width: localW * 0.2,
                            height: localH * 0.05,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned.fill(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: SizedBox(
                                      width: localW * 0.2,
                                      child: CustomText(
                                        txtAlign: TextAlign.center,
                                        txt: item.discountPrice == null
                                            ? ''
                                            : item.discountPrice.toString(),
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
                          );
                        }
                      }),
                      AutoTextSize(
                        text: item.price == null
                            ? 0.toString()
                            : item.price.toString(),
                        textColor: Colors.green,
                        size: localW * 0.038,
                        fontWeight: FontWeight.bold,
                      ),
                      AutoTextSize(
                        text: ' EGP',
                        textColor: Colors.green,
                        size: localW * 0.038,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                    height: localH * 0.06,
                    child: AutoTextSize(
                      text: item.level,
                      textColor: ConstStyles.BlackColor,
                      size: localW * 0.038,
                    )),

                //TODO Teacher
                Container(
                  height: localH * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: ConstStyles.TextColor,
                        child: GetBuilder<StudProfCont>(
                          builder: (_) {
                            if (item.teacherImg != null) {
                              return CustomNetworkImage(
                                url: '${EndPoints.ImageUrl}${item.teacherImg}',
                                newImage: () {},
                                radius: 50.0,
                              );
                            } else {
                              return LogoContainer();
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: localW * 0.03,
                      ),
                      GetBuilder<StudProfCont>(builder: (_) {
                        if (item.teacher.length > 0) {
                          return CustomText(
                            txt: item.teacher[0].name,
                            txtColor: ConstStyles.TextColor,
                            fontSize: localW * 0.04,
                          );
                        } else {
                          return CustomText(
                            txt: '',
                            txtColor: ConstStyles.TextColor,
                            fontSize: localW * 0.04,
                          );
                        }
                      }),
                      GetBuilder<StudProfCont>(builder: (_) {
                        if (item.teacher.length > 0) {
                          return CustomText(
                            txt: item.teacher[0].qualifications == null
                                ? ''
                                : item.teacher[0].qualifications,
                            txtColor: ConstStyles.TextColor,
                            fontSize: localW * 0.04,
                          );
                        } else {
                          return CustomText(
                            txt: '',
                            txtColor: ConstStyles.TextColor,
                            fontSize: localW * 0.04,
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: localH * 0.02,
            child: Divider(
              thickness: 1,
              color: ConstStyles.BlackColor,
            ),
          ),
          Center(
            child: OrangeBtn(
              btnColor: ConstStyles.BlueColor,
              text: 'Score',
              onClick: () {
                return Get.defaultDialog(
                  title: 'YourScore',
                  content: Column(
                    children: [
                      SizedBox(height: 10),
                      FlatButton(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text("Placement"),
                        onPressed: () {
                          return Get.defaultDialog(
                            title: 'Placement',
                            content: Column(
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Score: "),
                                    Text("${item.placement['score']} /"),
                                    Text("${item.placement['total']}"),
                                    SizedBox(width: 15),
                                    "${item.placement['pass']}" == "0"
                                        ? Text("X",
                                            style: TextStyle(color: Colors.red))
                                        : Icon(Icons.done, color: Colors.green),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: localW,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.red,
                                      child: Text("Back"),
                                      onPressed: () {
                                        Get.back();
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.amber,
                        child: Text("Final Exam"),
                        onPressed: () {
                          return Get.defaultDialog(
                            title: 'Final Exam',
                            content: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Score: "),
                                    Text("${item.finalExam['score']} /"),
                                    Text("${item.finalExam['total']}"),
                                    SizedBox(width: 15),
                                    "${item.finalExam['pass']}" == "0"
                                        ? Text("X",
                                            style: TextStyle(color: Colors.red))
                                        : Icon(Icons.done, color: Colors.green),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Container(
                                  width: localW,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      color: Colors.red,
                                      child: Text("Back"),
                                      onPressed: () {
                                        Get.back();
                                      }),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: localW,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.red,
                            child: Text("Back"),
                            onPressed: () {
                              Get.back();
                            }),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget myClassesItem(localH, localW, MyClassesDataList item) {
    return Container(
      margin: EdgeInsets.only(bottom: localH * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO Teacher Name
          Row(
            children: [
              AutoTextSize(
                text: "${'TeacherName'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.teacher[0] == null ? ' ' : item.teacher[0].name,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Course Name
          Row(
            children: [
              AutoTextSize(
                text: "${'CourseName'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.name,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Weeks
          Row(
            children: [
              AutoTextSize(
                text: "${'WeeksNumber'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.weeks.toString(),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Lesson
          Row(
            children: [
              AutoTextSize(
                text: "${'LessonsNumber'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.lessons.toString(),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Next Lesson
          Row(
            children: [
              AutoTextSize(
                text: "${'NextLesson'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: '${item.lessons + 1}',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.02,
          ),
          OrangeBtn(
            text: 'Show'.tr,
            onClick: () {
              _cont.showLesson(item.key, item.name);
            },
            btnColor: ConstStyles.GreenColor,
          ),

          Container(
            height: localH * 0.02,
            margin: EdgeInsets.only(left: localW * 0.08, right: localW * 0.08),
            child: Divider(
              thickness: 1,
              color: ConstStyles.BlackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget myPrivateClassesItem(localH, localW, MyPrivateClassesDataList item) {
    return Container(
      margin: EdgeInsets.only(bottom: localH * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //TODO Teacher Name
          Row(
            children: [
              AutoTextSize(
                text: "${'TeacherName'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.teacher[0] == null ? ' ' : item.teacher,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),

          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Course Name
          Row(
            children: [
              AutoTextSize(
                text: "${'CourseName'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.name,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Weeks
          Row(
            children: [
              AutoTextSize(
                text: "${'WeeksNumber'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.weeks.toString(),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Lesson
          Row(
            children: [
              AutoTextSize(
                text: "${'LessonsNumber'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: item.lessons.toString(),
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.012,
          ),
          //TODO Next Lesson
          Row(
            children: [
              AutoTextSize(
                text: "${'NextLesson'.tr} : ",
                fontWeight: FontWeight.bold,
                textColor: ConstStyles.BlackColor,
              ),
              AutoTextSize(
                text: '${item.lessons + 1}',
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: localH * 0.02,
          ),
          //TODO Show
          OrangeBtn(
            text: 'Show'.tr,
            onClick: () {
              _cont.showPrivateLesson(item.key, item.name);
            },
            btnColor: ConstStyles.GreenColor,
          ),

          Container(
            height: localH * 0.02,
            margin: EdgeInsets.only(left: localW * 0.08, right: localW * 0.08),
            child: Divider(
              thickness: 1,
              color: ConstStyles.BlackColor,
            ),
          ),
        ],
      ),
    );
  }
}
