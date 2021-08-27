import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/Auth/Login/LoginCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/CustomForm.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/VerificationForm.dart';
import 'package:troom/Models/Auth/Login/LoginReqData.dart';
import 'package:troom/Models/Auth/Verification/VerificationReq.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/Auth/Register.dart';
import 'package:troom/View/Home.dart';

class Login extends GetView<LoginCont> {
  static const Id = 'LoginScreen';
  String LOGD = 'LoginScreen-->';
  var _formKey = GlobalKey<FormState>();
  final LoginCont _loginCont = Get.put(LoginCont());
  var _verifyFormKey = GlobalKey<FormState>();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  final focus4 = FocusNode();
  final focus5 = FocusNode();
  final focus6 = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarText(
          txt: 'SignIn'.tr,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(
          builder: (_){
            return ModalProgressHUD(
                inAsyncCall: _loginCont.modalHudController.isLoading,
                child: Container(
                  child: LayoutBuilder(
                    builder: (ctx, cons) {
                      var localH = cons.maxHeight;
                      var localW = cons.maxWidth;
                      return GetBuilder<LoginCont>(builder: (_){
                        return Column(
                          children: [
                            //TODO Logo
                            Container(
                              height: localH * 0.25,
                              child: LogoContainer(),
                            ),

                            //TODO
                            Container(
                              decoration: BoxDecoration(
                                color: ConstStyles.DarkColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(70),
                                    topLeft: Radius.circular(70)),
                              ),
                              height: localH * 0.75,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: localW * 0.08, left: localW * 0.08),
                                child: Form(
                                  key: _formKey,
                                  child: ListView(
                                    children: [

                                      //TODO E-mail
                                      SizedBox(
                                        height: localH * 0.15,
                                      ),
                                      CustomForm(
                                        hint: 'Email'.tr,
                                        keybord: TextInputType.emailAddress,
                                        obscureText: false,
                                        onSave: (v){
                                          _loginCont.email = v;
                                        },
                                      ),

                                      //TODO Password
                                      SizedBox(
                                        height: localH * 0.05,
                                      ),
                                      CustomForm(
                                        hint: 'Password'.tr,
                                        keybord: TextInputType.text,
                                        obscureText: true,
                                        onSave: (v){
                                          _loginCont.password = v;
                                        },
                                      ),

                                      //TODO Login Btn
                                      SizedBox(
                                        height: localH * 0.15,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: localW * 0.2, right: localW * 0.2),
                                        child: OrangeBtn(
                                          text: 'LogIn'.tr,
                                          onClick: () async{
                                            print('Login Clicked');
                                            _formKey.currentState.save();
                                            _loginCont.loginReqData = LoginReqData(
                                                email: _loginCont.email,
                                                password: _loginCont.password,);
                                            print('$LOGD Register Btn ::: ${jsonEncode(_loginCont.loginReqData)}');
                                            if(await  _loginCont.checkLoginRes()){
                                              Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                  colorText: ConstStyles.WhiteColor,
                                                  titleText: CustomText(txt: 'LoggingSuccess'.tr,
                                                    txtAlign: TextAlign.center,));
                                              Get.back();
                                              await FlutterRestart.restartApp();
                                              // Get.forceAppUpdate();
                                              // Get.offAllNamed(Home.Id);
                                            }else if(_loginCont.loginErrorMessage.length>0){
                                              if(_loginCont.loginErrorMessage[0]=='You should verify you phone'){
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return GetBuilder<ModalHudCont>(builder: (_){
                                                        return ModalProgressHUD(
                                                          inAsyncCall: _loginCont.modalHudController.isLoading,
                                                          child: AlertDialog(
                                                              content: Container(
                                                                height: localH * 0.7,
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                  children: [
                                                                    //TODO Dialog Text
                                                                    SizedBox(
                                                                        height: localH * 0.1,
                                                                        child: CustomText(txt: "Success to create account ,should verify phone...",txtColor: ConstStyles.TextColor,)),

                                                                    //TODO Verification Code
                                                                    SizedBox(
                                                                      width: localW,
                                                                      height: localH * 0.15,
                                                                      child: Form(
                                                                        key: _verifyFormKey,
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                                          children: [
                                                                            Expanded(child: VerificationForm(
                                                                              focus: true,
                                                                              inputAction: TextInputAction.next,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode = v;
                                                                                FocusScope.of(context).requestFocus(focus1);
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode = v;
                                                                              },
                                                                            ),),

                                                                            Expanded(child: VerificationForm(
                                                                              focusNode: focus1,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode += v;
                                                                                FocusScope.of(context).requestFocus(focus2);
                                                                                // focus.nextFocus();
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode += v;
                                                                              },
                                                                            ),),

                                                                            Expanded(child: VerificationForm(
                                                                              focusNode: focus2,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode += v;
                                                                                FocusScope.of(context).requestFocus(focus3);
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode += v;
                                                                              },
                                                                            ),),
                                                                            Expanded(child: VerificationForm(
                                                                              focusNode: focus3,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode += v;
                                                                                FocusScope.of(context).requestFocus(focus4);
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode += v;
                                                                              },
                                                                            ),),
                                                                            Expanded(child: VerificationForm(
                                                                              focusNode: focus4,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode += v;
                                                                                FocusScope.of(context).requestFocus(focus5);
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode += v;
                                                                              },
                                                                            ),),
                                                                            Expanded(child: VerificationForm(
                                                                              focusNode: focus5,
                                                                              keybord: TextInputType.number,
                                                                              onChange: (v){
                                                                                _loginCont.verificationCode += v;
                                                                                FocusScope.of(context).unfocus();
                                                                              },
                                                                              onSave: (v){
                                                                                _loginCont.verificationCode += v;
                                                                              },
                                                                            ),),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),

                                                                    //TODO Verify Btn
                                                                    SizedBox(
                                                                      height: localH * 0.1,
                                                                      child: OrangeBtn(text: 'Verify', onClick: ()async{
                                                                        _verifyFormKey.currentState.save();
                                                                        _loginCont.codeReq = VerificationReq(_loginCont.verificationCode);
                                                                        print('$LOGD VerificationCode = ${_loginCont.verificationCode}');
                                                                        if( await _loginCont.checkCode(_loginCont.codeReq,_loginCont.loginResDataFalse.userKey, )){
                                                                          Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                              colorText: ConstStyles.WhiteColor,
                                                                              titleText: CustomText(txt: 'VerifiedSuccess'.tr,
                                                                                txtAlign: TextAlign.center,));
                                                                          // Get.back();
                                                                          Get.offAllNamed(Home.Id);
                                                                        }else{
                                                                          Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                              colorText: ConstStyles.WhiteColor,
                                                                              titleText: CustomText(txt: _loginCont.loginErrorMessage[0],
                                                                                txtAlign: TextAlign.center,));
                                                                        }
                                                                      }),
                                                                    ),
                                                                    //TODO Resend code Btn
                                                                    SizedBox(
                                                                      height: localH * 0.1,
                                                                      child: OrangeBtn(text: 'Resend Code', onClick: ()async{
                                                                        if(await _loginCont.resendCode(_loginCont.loginResDataFalse.userKey)){
                                                                          Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                              colorText: ConstStyles.WhiteColor,
                                                                              titleText: CustomText(txt: 'MessageSentSuccessfully'.tr,
                                                                                txtAlign: TextAlign.center,));
                                                                        }else{
                                                                          Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                              colorText: ConstStyles.WhiteColor,
                                                                              titleText: CustomText(txt: _loginCont.loginErrorMessage[0],
                                                                                txtAlign: TextAlign.center,));
                                                                        }
                                                                      }),
                                                                    ),

                                                                  ],
                                                                ),
                                                              )
                                                          ),
                                                        );
                                                      });
                                                    });
                                                Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                    colorText: ConstStyles.WhiteColor,
                                                    titleText: CustomText(txt: _loginCont.loginErrorMessage[0],
                                                      txtAlign: TextAlign.center,));
                                              }else{
                                                Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                    colorText: ConstStyles.WhiteColor,
                                                    titleText: CustomText(txt: _loginCont.loginErrorMessage[0],
                                                      txtAlign: TextAlign.center,));
                                              }
                                            }
                                          },
                                        ),
                                      ),

                                      //TODO SignUp Btn
                                      SizedBox(
                                        height: localH * 0.04,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            CustomText(txt: 'DoNotHaveAccount'.tr,txtColor: ConstStyles.TextColor,),
                                            SizedBox(width: localW * 0.025,),
                                            OrangeBtn(
                                              text: 'RegisterNow'.tr,
                                              onClick: () {
                                                Get.toNamed(Register.Id);
                                                print('Sign up Clicked');
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      });
                    },
                  ),
                ),);
          },
        ),
      ),
    );
  }
}
