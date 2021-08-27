import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_plugin/zoom_view.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Controller/Zoom/ZoomCont.dart';
import 'package:troom/Util/ConstStyles.dart';

class ZoomMeet extends StatelessWidget {
  String LOGD = 'ZoomMeetView-->';
   ZoomCont _cont;
   var _lessonKey;

   ZoomMeet(this._lessonKey,){
    _cont = Get.put(ZoomCont(_lessonKey));
  }

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;

    return Scaffold(
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      body: SafeArea(
          child:  GetBuilder<ModalHudCont>(
            builder: (_){
              return ModalProgressHUD(
                inAsyncCall: _cont.modalHudController.isLoading,
                child: GetBuilder<ZoomCont>(
                  builder: (_){
                    if(_cont.showMeetingResData.meetingId==null){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }else{
                      return Container(
                        child: ZoomView(
                          onViewCreated: (controller){
                            controller.initZoom(_cont.zoomOptions).then((results) {
                              print("$LOGD Meeting Status Stream:--> ${results[0].toString()}");
                              if(results[0] == 0){
                                controller.zoomStatusEvents.listen((status) {
                                  print("$LOGD Meeting Status Stream: " + status[0] + " - " + status[1]);
                                  if(_cont.isMeetingEnded(status[0])){
                                    Get.back();
                                    _cont.timer.cancel();
                                  }
                                });
                                print("$LOGD listen on event channel");

                                controller.joinMeeting(_cont.meetingOptions).then((joinMeetingResult) {
                                  _cont.timer = Timer.periodic(new Duration(seconds: 2), (timer) {
                                    controller.meetingStatus(_cont.meetingOptions.meetingId).then((status)  {
                                      print("$LOGD Meeting Status Polling: " + status[0] + " - " + status[1]);
                                    });
                                  });
                                });
                              }

                            }).catchError((e){
                              print('$LOGD Error: $e');
                            });
                          },
                        ),
                      );
                    }
                  },
                ),
              );
            },
          )
        ,),
    );
  }
}
