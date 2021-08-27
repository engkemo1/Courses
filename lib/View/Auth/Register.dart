import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/Auth/Register/RegisterCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/CustomForm.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/CustomViews/VerificationForm.dart';
import 'package:troom/Models/Auth/Register/RegisterReqData.dart';
import 'package:troom/Models/Auth/Verification/VerificationReq.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/Auth/Login.dart';
import 'package:troom/View/Home.dart';

class Register extends GetView<RegisterCont> {
  static const Id = 'RegisterScreen';
  String LOGD = 'RegisterScreen-->';
  var _formKey = GlobalKey<FormState>();
  final RegisterCont _registerCont = Get.put(RegisterCont());
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
          txt: 'SignUp'.tr,
        ),
      ),
      body: SafeArea(
        child: GetBuilder<ModalHudCont>(
          builder: (_){
            return ModalProgressHUD(
              inAsyncCall: _registerCont.modalHudController.isLoading,
              child: Container(
                child: LayoutBuilder(
                  builder: (ctx, cons) {
                    var localH = cons.maxHeight;
                    var localW = cons.maxWidth;
                    return GetBuilder<RegisterCont>(builder: (_){
                      return ListView(
                        children: [

                          //TODO Logo
                          Container(
                            height: localH * 0.2,
                            child: LogoContainer(),
                          ),

                          //TODO Data
                          Container(
                            decoration: BoxDecoration(
                              color: ConstStyles.DarkColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(70),
                                  topLeft: Radius.circular(70)),
                            ),
                            height: localH * 0.6,
                            child: Container(
                              margin: EdgeInsets.only(
                                  right: localW * 0.08, left: localW * 0.08),
                              padding: EdgeInsets.only(top: localH * 0.05),
                              child: SizedBox(
                                child: Form(
                                  key: _formKey,
                                  child: ListView(
                                    children: [
//TODO Name
                                      CustomForm(
                                        hint: 'FullName'.tr,
                                        obscureText: false,
                                        keybord: TextInputType.text,
                                        onSave: (v){
                                          _registerCont.name = v;
                                        },
                                      ),

//TODO Phone Number
                                      SizedBox(
                                        height: localH * 0.05,
                                      ),
/*
                                      SizedBox(
                                        width: localW,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: localW * 0.2,
                                              child: CustomForm(
                                                hint: 'Country Code',
                                                hintSize: localW * 0.024,
                                                keybord: TextInputType.number,
                                                obscureText: false,
                                                onSave: (v){
                                                  _registerCont.countryCode = v;
                                                },
                                              ),
                                            ),
                                            SizedBox(width: localW * 0.01,),
                                            Expanded(
                                              // width: localW * 0.65,
                                              child: CustomForm(
                                                hint: 'PhoneNumber'.tr,
                                                keybord: TextInputType.number,
                                                obscureText: false,
                                                onSave: (v){
                                                  if(v.toString().startsWith('0')){
                                                    _registerCont.phone = '+' + _registerCont.countryCode + v.toString().replaceFirst('0', '');
                                                  }else{
                                                    _registerCont.phone = '+' + _registerCont.countryCode + v;
                                                  }

                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
*/
                                      Container(
                                        // color: ConstStyles.WhiteColor,
                                        width: localW,
                                        child: InternationalPhoneNumberInput(
                                          onInputChanged: (PhoneNumber number) {
                                            print(number.phoneNumber);
                                          },
                                          onInputValidated: (bool value) {
                                            print(value);
                                          },
                                          selectorConfig: SelectorConfig(
                                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                                          ),
                                          ignoreBlank: false,
                                          autoValidateMode: AutovalidateMode.disabled,
                                          // inputBorder: OutlineInputBorder(
                                          //   borderSide: BorderSide(color: ConstStyles.WhiteColor),
                                          //   borderRadius: BorderRadius.circular(10),
                                          // ),
                                          // inputBorder: InputBorder(),
                                          selectorTextStyle: TextStyle(color: ConstStyles.WhiteColor),
                                          // initialValue: ,
                                          // textFieldController: controller,
                                          formatInput: false,
                                          textStyle: TextStyle( color: ConstStyles.WhiteColor,fontWeight: FontWeight.bold,fontSize: 20),
                                          keyboardType:
                                          TextInputType.numberWithOptions(signed: true, decimal: true),
                                          inputDecoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ConstStyles.WhiteColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(color: ConstStyles.WhiteColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(color: ConstStyles.WhiteColor),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            // fillColor: ConstStyles.WhiteColor,
                                            filled: true,
                                            labelText: 'PhoneNumber'.tr,
                                            labelStyle: TextStyle(color: ConstStyles.TextColor,fontWeight: FontWeight.bold,
                                                fontSize:20),
                                          ),
                                          onSaved: (PhoneNumber v) {
                                            print('On Saved: ${v.parseNumber()}');
                                            String num = v.parseNumber();
                                            if(num.length > 2){
                                              if(num.startsWith('0')){
                                                num =  num.replaceFirst('0', '');
                                                print('On _registerCont.phone: ${num}');
                                                _registerCont.phone = v.dialCode + num;
                                              }else{
                                                num = v.phoneNumber;
                                                print('On _registerCont.phone:2 ${num}');
                                                _registerCont.phone = num;
                                              }
                                            }else {
                                              Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                  colorText: ConstStyles.WhiteColor,
                                                  titleText: CustomText(txt: 'AllDataRequired'.tr,
                                                    txtAlign: TextAlign.center,));
                                            }
                                          },
                                        ),
                                      ),


//TODO E-mail
                                      SizedBox(
                                        height: localH * 0.05,
                                      ),
                                      CustomForm(
                                        hint: 'Email'.tr,
                                        keybord: TextInputType.emailAddress,
                                        obscureText: false,
                                        onSave: (v){
                                          _registerCont.email = v;
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
                                          _registerCont.password = v;
                                        },
                                      ),

//TODO Confirm Password
                                      SizedBox(
                                        height: localH * 0.05,
                                      ),
                                      CustomForm(
                                        hint: 'ConfirmPassword'.tr,
                                        keybord: TextInputType.text,
                                        obscureText: true,
                                        onSave: (v){
                                          _registerCont.confirmPassword = v;
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              ),),
                          ),

                          //TODO Btns
                          Container(
                            padding: EdgeInsets.only(top: localH * 0.012),
                            decoration: BoxDecoration(color: ConstStyles.DarkColor),
                            child: Column(
                              children: [
                                //TODO Register Btn
                                Container(
                                  margin: EdgeInsets.only(
                                      left: localW * 0.2,
                                      right: localW * 0.2),
                                  child: OrangeBtn(
                                    text: 'Register'.tr,
                                    onClick: () async{

                                      _formKey.currentState.save();
                                      _registerCont.registerReqData = RegisterReqData(_registerCont.name,
                                          _registerCont.email,_registerCont.password,_registerCont.confirmPassword,
                                          _registerCont.phone,_registerCont.userType);
                                      print('$LOGD Register Btn ::: ${_registerCont.phone} --> ${_registerCont.registerResData.key}');
                                      if(await _registerCont.registerData(_registerCont.registerReqData)){
                                        Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                            colorText: ConstStyles.WhiteColor,
                                            titleText: CustomText(txt: 'RegistrationSuccess'.tr,
                                              txtAlign: TextAlign.center,));
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return ModalProgressHUD(
                                                inAsyncCall: _registerCont.modalHudController.isLoading,
                                                child: AlertDialog(
                                                    content: Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                                                      _registerCont.verificationCode = v;
                                                                      FocusScope.of(context).requestFocus(focus1);
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode = v;
                                                                    },
                                                                  ),),

                                                                  Expanded(child: VerificationForm(
                                                                    focusNode: focus1,
                                                                    keybord: TextInputType.number,
                                                                    onChange: (v){
                                                                      _registerCont.verificationCode += v;
                                                                      FocusScope.of(context).requestFocus(focus2);
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode += v;
                                                                    },
                                                                  ),),

                                                                  Expanded(child: VerificationForm(
                                                                    focusNode: focus2,
                                                                    keybord: TextInputType.number,
                                                                    onChange: (v){
                                                                      _registerCont.verificationCode += v;
                                                                      FocusScope.of(context).requestFocus(focus3);
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode += v;
                                                                    },
                                                                  ),),
                                                                  Expanded(child: VerificationForm(
                                                                    focusNode: focus3,
                                                                    keybord: TextInputType.number,
                                                                    onChange: (v){
                                                                      _registerCont.verificationCode += v;
                                                                      FocusScope.of(context).requestFocus(focus4);
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode += v;
                                                                    },
                                                                  ),),
                                                                  Expanded(child: VerificationForm(
                                                                    focusNode: focus4,
                                                                    keybord: TextInputType.number,
                                                                    onChange: (v){
                                                                      _registerCont.verificationCode += v;
                                                                      FocusScope.of(context).requestFocus(focus5);
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode += v;
                                                                    },
                                                                  ),),
                                                                  Expanded(child: VerificationForm(
                                                                    focusNode: focus5,
                                                                    keybord: TextInputType.number,
                                                                    onChange: (v){
                                                                      _registerCont.verificationCode += v;
                                                                      FocusScope.of(context).unfocus();
                                                                    },
                                                                    onSave: (v){
                                                                      _registerCont.verificationCode += v;
                                                                    },
                                                                  ),),
                                                                ],
                                                              ),
                                                            ),
                                                          ),

                                                          //TODO Dialog Btn
                                                          SizedBox(
                                                            height: localH * 0.2,
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                              children: [
                                                                OrangeBtn(text: 'Verify', onClick: ()async{
                                                                  _verifyFormKey.currentState.save();
                                                                  _registerCont.codeReq = VerificationReq(_registerCont.verificationCode);
                                                                  print('$LOGD VerificationCode = ${_registerCont.verificationCode}');
                                                                  if( await _registerCont.checkCode(_registerCont.codeReq,_registerCont.registerResData.key, )){
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                        colorText: ConstStyles.WhiteColor,
                                                                        titleText: CustomText(txt: 'VerifiedSuccess'.tr,
                                                                          txtAlign: TextAlign.center,));
                                                                    Get.back();
                                                                    Get.offAllNamed(Home.Id);
                                                                  }else{
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                        colorText: ConstStyles.WhiteColor,
                                                                        titleText: CustomText(txt: _registerCont.registerErrorMessage[0],
                                                                          txtAlign: TextAlign.center,));
                                                                  }
                                                                }),
                                                                OrangeBtn(text: 'Resend Code', onClick: ()async{
                                                                  if(await _registerCont.resendCode(_registerCont.registerResData.key)){
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                        colorText: ConstStyles.WhiteColor,
                                                                        titleText: CustomText(txt: 'MessageSentSuccessfully'.tr,
                                                                          txtAlign: TextAlign.center,));
                                                                  }else{
                                                                    Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                                                        colorText: ConstStyles.WhiteColor,
                                                                        titleText: CustomText(txt: _registerCont.registerErrorMessage[0],
                                                                          txtAlign: TextAlign.center,));
                                                                  }
                                                                }),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                ),
                                              );
                                            });
                                      }else{
                                        if(_registerCont.registerErrorMessage.length>0){
                                          Get.snackbar('', '',backgroundColor: ConstStyles.DarkColor,
                                              colorText: ConstStyles.WhiteColor,
                                              titleText: CustomText(txt: _registerCont.registerErrorMessage[0],
                                                txtAlign: TextAlign.center,));
                                        }
                                      }
                                    },
                                  ),
                                ),

                                SizedBox(
                                  height: localH * 0.04,
                                ),

                                //TODO Login Btn
                                Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      CustomText(
                                        txt: 'HaveAccount'.tr,
                                        txtColor: ConstStyles.TextColor,
                                      ),
                                      SizedBox(
                                        width: localW * 0.025,
                                      ),
                                      OrangeBtn(
                                        text: 'LogInNow',
                                        onClick: () {
                                          Get.offAll(Login());
                                          print('Login now Clicked');
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    });
                  },
                ),
              ),
            );
          },
        )
      ),
    );
  }
}


