
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/Drawer/MainDrawerCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/AboutUs.dart';
import 'package:troom/View/ContactUs.dart';
import 'package:troom/View/Courses/AllCourses.dart';
import 'package:troom/View/LiveClasses/AllLiveCourses.dart';
import 'package:troom/View/Auth/Login.dart';
import 'package:troom/View/Auth/Register.dart';
import 'package:troom/View/Home.dart';
import 'package:troom/View/OurInstructors.dart';
import 'package:troom/View/StudentProfile/StudentProfile.dart';

class MainDrawer extends StatefulWidget {
  static const Id = 'MainDrawerScreen';

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  MainDrawerCont cont = Get.put(MainDrawerCont());

  @override
  void initState() {
    checkIsLogin();
    super.initState();
  }

  bool checkIsLogin() {
    if (cont.isLogged != null && cont.isLogged == true) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainDrawerCont>(
      init: Get.put(MainDrawerCont()),
        builder: (_) {
          print('${MainDrawer.Id}  ${cont.isLogged}');
          //TODO Already Logged in

          if (checkIsLogin()) {
            return Drawer(
              child: Container(
                color: ConstStyles.WhiteColor,
                child: ListView(
                  children: <Widget>[
                    //TODO Drawer Header
                    DrawerHeader(
                        decoration: BoxDecoration(color: ConstStyles.WhiteColor),
                        padding: EdgeInsets.all(10),
                        child: LayoutBuilder(
                          builder: (context, constrains) {
                            var localH = constrains.maxHeight;
                            var localW = constrains.maxWidth;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: localW,
                                  height: localH,
                                  child: LogoContainer(
                                    colors: ConstStyles.WhiteColor,
                                  ),
                                ),
                              ],
                            );
                          },
                        )),

                    //TODO Home
                    ListTile(
                      title: CustomText(
                        txt: 'Home'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: Home Clicked');
                        Get.back();
                        Get.offAllNamed(Home.Id);
                      },
                    ),

                    //TODO Profile
                    ListTile(
                      title: CustomText(
                        txt: 'MyProfile'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: Profile Clicked');
                        Get.back();
                        Get.toNamed(StudentProfile.Id);
                      },
                    ),

                    //TODO About Us
                    ListTile(
                      title: CustomText(
                        txt: 'AboutUs'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: AboutUs Clicked');
                        Get.back();
                        Get.toNamed(AboutUs.Id);
                      },
                    ),

                    //TODO All Courses
                    ListTile(
                      title: CustomText(
                        txt: 'AllRecordedCourses'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print('Nav :: AllCourses Clicked');
                        Get.back();
                        Get.toNamed(AllCourses.Id);
                      },
                    ),

                    //TODO Live Classes
                    ListTile(
                      title: CustomText(
                        txt: 'AllLiveClasses'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print(' ::Nav LiveClasses Clicked');
                        Get.back();
                        Get.toNamed(AllLiveCourses.Id);
                      },
                    ),

                    //TODO our instructor
                    ListTile(
                      title: CustomText(
                        txt: 'Teachers'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                       Navigator.push(context,MaterialPageRoute(builder: (_)=>OurInstructor()));
                      },
                    ),

                    //TODO contact us
                    ListTile(
                      title: CustomText(
                        txt: 'ContactUs'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: ContactUs Clicked');
                        Get.back();
                        Get.toNamed(ContactUs.Id);
                      },
                    ),

                    //TODO language
                    ListTile(
                      title: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: CustomText(
                              txt: 'Arabic'.tr,
                              txtColor: ConstStyles.TextColor,
                            ),
                            value: 'ar',
                          ),
                          DropdownMenuItem(
                            child: CustomText(
                              txt: 'English'.tr,
                              txtColor: ConstStyles.TextColor,
                            ),
                            value: 'en',
                          ),
                        ],
                        value: cont.appLang,
                        onChanged: (value) {
                          cont.changeLang(value);
                          Get.updateLocale(Locale(cont.appLang));
                        },
                      ),
                    ),

                    //TODO Logout
                    ListTile(
                      title: CustomText(
                        txt: 'LogOut'.tr,
                        txtColor: ConstStyles.OrangeColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: LogOut Clicked');
                        if (await cont.checkLogoutRes()) {
                          // Get.offAllNamed(Home.Id);
                          Get.back();
                          Get.offAll(Home());
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return Drawer(
              child: Container(
                color: ConstStyles.WhiteColor,
                child: ListView(
                  children: <Widget>[
                    DrawerHeader(
                        decoration: BoxDecoration(color: ConstStyles.WhiteColor),
                        padding: EdgeInsets.all(10),
                        child: LayoutBuilder(
                          builder: (context, constrains) {
                            var localH = constrains.maxHeight;
                            var localW = constrains.maxWidth;
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: localW,
                                  height: localH,
                                  child: LogoContainer(
                                    colors: ConstStyles.WhiteColor,
                                  ),
                                ),
/*
                        SizedBox(
                          height: localH * 0.2,
                          child: CustomText(txt: 'Mohamed Tharwat',txtColor: ConstStyles.WhiteColor,)
                        ),

                        SizedBox(
                          height: localH * 0.2,
                          child: CustomText(txt: '01111111111',txtColor: ConstStyles.WhiteColor,)
                        ),*/
                              ],
                            );
                          },
                        )),

                    //TODO Home
                    ListTile(
                      title: CustomText(
                        txt: 'Home'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: Home Clicked');
                        Get.back();
                        Get.toNamed(Home.Id);
                      },
                    ),

                    //TODO About Us
                    ListTile(
                      title: CustomText(
                        txt: 'AboutUs'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: AboutUs Clicked');
                        Get.back();
                        Get.toNamed(AboutUs.Id);
                      },
                    ),

                    //TODO All Courses
                    ListTile(
                      title: CustomText(
                        txt: 'AllRecordedCourses'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print('Nav :: AllCourses Clicked');
                        Get.back();
                        Get.toNamed(AllCourses.Id);
                      },
                    ),
                    //TODO Live Classes
                    ListTile(
                      title: CustomText(
                        txt: 'AllLiveClasses'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print(' ::Nav LiveClasses Clicked');
                        Get.back();
                        Get.toNamed(AllLiveCourses.Id);
                      },
                    ),
                    //TODO our instructor
                    ListTile(
                      title: CustomText(
                        txt: 'Teachers'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_)=>OurInstructor()));
                      },
                    ),
                    //TODO contact us
                    ListTile(
                      title: CustomText(
                        txt: 'ContactUs'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () async {
                        Navigator.pop(context);
                        print('Nav :: ContactUs Clicked');
                        Get.back();
                        Get.toNamed(ContactUs.Id);
                      },
                    ),
                    //TODO Sign in
                    ListTile(
                      title: CustomText(
                        txt: 'SignIn'.tr,
                        txtColor: ConstStyles.OrangeColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print('Nav :: LogOut Clicked');
                        Get.back();
                        Get.toNamed(Login.Id);
                      },
                    ),
                    //TODO Sign up
                    ListTile(
                      title: CustomText(
                        txt: 'SignUp'.tr,
                        txtColor: ConstStyles.TextColor,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        print('Nav :: LogOut Clicked');
                        Get.back();
                        Get.toNamed(Register.Id);
                      },
                    ),

                    //TODO language
                    ListTile(
                      title: DropdownButton(
                        items: [
                          DropdownMenuItem(
                            child: CustomText(
                              txt: 'Arabic'.tr,
                              txtColor: ConstStyles.TextColor,
                            ),
                            value: 'ar',
                          ),
                          DropdownMenuItem(
                            child: CustomText(
                              txt: 'English'.tr,
                              txtColor: ConstStyles.TextColor,
                            ),
                            value: 'en',
                          ),
                        ],
                        value: cont.appLang,
                        onChanged: (value) {
                          cont.changeLang(value);
                          Get.updateLocale(Locale(cont.appLang));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }
}
