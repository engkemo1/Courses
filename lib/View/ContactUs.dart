import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/ContactUs/ContactUsCont.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/CustomViews/AppBarText.dart';
import 'package:troom/CustomViews/CustomProfForm.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/MainDrawer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ContactUs extends GetView<ContactUsCont> {
  static const Id = 'ContactUsScreen';
  ContactUsCont _cont = Get.put(ContactUsCont());
  var _formKey = GlobalKey<FormState>();

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
            inAsyncCall: _cont.modalHudController.isLoading,
            child: Container(
                child: LayoutBuilder(
              builder: (context, cons) {
                var localW = cons.maxWidth;
                var localH = cons.maxHeight;
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [

                      SizedBox(
                        height: localH * 0.45,
                        child: ListView(

                          children: [
                            //TODO ContactUs Title
                            SizedBox(
                              height: localH * 0.075,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomText(
                                    txt: 'ContactUs'.tr,
                                    fontSize: localW * 0.09,
                                    txtColor: ConstStyles.BlackColor,
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
                              height: localH * 0.015,
                            ),

                            //TODO Your Name
                            Container(
                              height: localH * 0.1,
                              margin: EdgeInsets.only(left: localW * 0.1,right: localW * 0.1,bottom: localH * 0.01),
                              child: CustomProfForm(
                                myController: TextEditingController(
                                    text: _cont.name == null ? null : _cont.name
                                ),
                                hint: 'YourName'.tr,
                                keybord: TextInputType.text,
                                onSave: (v){
                                  _cont.name = v;
                                },
                                onChange: (v){
                                  _cont.name = v;
                                },
                              ),
                            ),

                            //TODO Your Message
                            Container(
                              height: localH * 0.15,
                              margin: EdgeInsets.only(left: localW * 0.1,right: localW * 0.1,bottom: localH * 0.01),
                              child: CustomProfForm(
                                myController: TextEditingController(
                                    text: _cont.massage == null ? null : _cont.massage
                                ),
                                hint: 'Message'.tr,
                                keybord: TextInputType.text,
                                onSave: (v){
                                  _cont.massage = v;
                                },
                                onChange: (v){
                                  _cont.massage = v;
                                },
                                minLines: 4,
                                maxLin: 30,
                              ),
                            ),

                            //TODO Send Btn
                            SizedBox(
                              height: localH * 0.05,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: localW * 0.1,right: localW * 0.1),

                                    child: OrangeBtn(text: 'Send'.tr, onClick: (){
                                      _formKey.currentState.save();
                                      _cont.prepareMsgReq();
                                    },),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),


                      //TODO Google map
                      Container(
                        margin: EdgeInsets.only(left: localW * 0.05,right: localW * 0.05,bottom: localH * 0.01,top: localH * 0.01),
                        width: localW,
                        height: localH * 0.51,
                        child: GetBuilder<ContactUsCont>(
                          builder: (_){
                            if(Platform.isAndroid){
                              return GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: const LatLng(30.0444, 31.2357),
                                  zoom: 10,
                                ),
                                zoomControlsEnabled: false,
                                myLocationButtonEnabled: false,
                                onMapCreated: (controller) => _cont.googleMapController = controller,
                                markers: {
                                  if(_cont.locationMarker != null ) _cont.locationMarker
                                },
                                onLongPress: _cont.addMarker,
                              );
                            }else{
                              return LogoContainer();
                            }
                          },
                        ),
                      )


                    ],
                  ),
                );
              },
            )),
          );
        },
      )),
    );
  }
}
