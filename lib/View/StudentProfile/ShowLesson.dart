import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/OrangeBtn.dart';
import 'package:troom/Models/Profile/StudentProfile/MyClasses/MyClassesLessons/ShowMyClassesLessonDataList.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/View/LiveClasses/ZoomMeet.dart';

class ShowLesson extends StatelessWidget {

   List<ShowMyClassesLessonDataList> _lessonsList = [];
   String _className = '';


  ShowLesson(this._lessonsList,this._className);

  @override
  Widget build(BuildContext context) {
    var appBarH = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar( title: Image.asset('assets/images/logo.png',fit: BoxFit.contain,height: appBarH,),
        backgroundColor: ConstStyles.WhiteColor,
        iconTheme: IconThemeData(color: ConstStyles.DarkColor),
      ),
      body: Container(
        child: LayoutBuilder(
          builder: (context,cons){
            var localW = cons.maxWidth;
            var localH = cons.maxHeight;
            return ListView(
              children: [
                SizedBox(height: localH * 0.05,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoTextSize(
                      textColor: ConstStyles.BlackColor,
                      text: 'Show ',
                      fontWeight: FontWeight.bold,
                      size: localW*0.06,),
                    AutoTextSize(
                      textColor: ConstStyles.OrangeColor,
                      text: 'Lesson',
                      fontWeight: FontWeight.bold,
                      size: localW*0.06,),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: localW * 0.25,right: localW * 0.25),
                  child: Divider(
                    thickness: 3,
                    color: ConstStyles.OrangeColor,
                  ),
                ),
                SizedBox(height: localH * 0.1,),

                Center(
                  child: Padding(
                    padding:  EdgeInsets.only(left: localW * 0.05),
                    child: AutoTextSize(
                      textColor: ConstStyles.BlackColor,
                      text:  _className,
                      fontWeight: FontWeight.bold,
                      size: localW*0.06,),
                  ),
                ),
                Divider(
                  thickness: 1,
                  color: ConstStyles.BlackColor,
                ),

               Container(
                 height: MediaQuery.of(context).size.height*.64,
                 padding: EdgeInsets.only(left: localW * 0.03,right: localW * 0.03),
                 child: SizedBox(
                   height: localH,
                   child: ListView.builder(
                       itemCount: _lessonsList.length,
                       itemBuilder: (context,index){

                         return Container(
                           margin: EdgeInsets.only(top: localH * 0.02),
                           child: Column(
                             children: [
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [

                                   AutoTextSize(
                                     textColor: ConstStyles.BlackColor,
                                     text:  _lessonsList[index].name == null ? '' : _lessonsList[index].name,
                                     fontWeight: FontWeight.bold,
                                     size: localW*0.04,),

                                   AutoTextSize(
                                     textColor: ConstStyles.BlackColor,
                                     text:  _lessonsList[index].status,
                                     fontWeight: FontWeight.bold,
                                     size: localW*0.04,),
                                 ],
                               ),
                               SizedBox(height: localH * 0.02,),
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Column(
                                     children: [
                                       Row(
                                         children: [
                                           AutoTextSize(
                                             textColor: ConstStyles.BlackColor,
                                             text:  _lessonsList[index].day.substring(0,3) + ' ',
                                             // fontWeight: FontWeight.bold,
                                             size: localW*0.04,),
                                           AutoTextSize(
                                             textColor: ConstStyles.BlackColor,
                                             text:  _lessonsList[index].date + ' ',
                                             // fontWeight: FontWeight.bold,
                                             size: localW*0.04,),
                                         ],
                                       ),
                                       AutoTextSize(
                                         textColor: ConstStyles.BlackColor,
                                         text:  _lessonsList[index].time.substring(0,5) + ' AM',
                                         // fontWeight: FontWeight.bold,
                                         size: localW*0.04,),
                                     ],
                                   ),

                                   OrangeBtn(text: _lessonsList[index].meeting == false ? 'No Meeting':
                                   'Attend', onClick: (){
                                     if(_lessonsList[index].meeting){
                                       Get.to(()=>ZoomMeet(_lessonsList[index].key));
                                     }
                                   },
                                     btnColor:_lessonsList[index].meeting == false ?ConstStyles.WhiteColor : ConstStyles.GreenColor ,
                                   txtColor: _lessonsList[index].meeting == false ? ConstStyles.BlackColor : null,)
                                 ],
                               ),

                               Divider(
                                 thickness: 2,
                                 color: ConstStyles.OrangeColor,
                               ),
                             ],
                           ),
                         );
                   }),
                 ),
               ),
              ],
            );
          },
        ),
      ),
    );
  }
}
