import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/Instructors/Inst.dart';
import 'package:troom/Models/Instructors/InstructorCourses.dart';
import 'package:troom/Models/Instructors/InstructorsDetails.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/Courses/CourseListItem.dart';

import 'Courses/CourseDetails.dart';
import 'LiveClasses/LiveCourseDetails.dart';
import 'LiveClasses/LiveCourseListItem.dart';
import 'MainDrawer.dart';

enum Swith {
  Courses,
  LiveCourse,
}
class InstructorScreen extends StatefulWidget {
  InstData t;
  InstructorScreen({this.t});
  InsApi a = InsApi();

  @override
  _InstructorScreenState createState() => _InstructorScreenState();
}

class _InstructorScreenState extends State<InstructorScreen> {
  final HomeCont _homeCont = Get.put(HomeCont());

  Swith s =Swith.Courses;



  @override
  Widget build(BuildContext context) {
    var kemo= _homeCont.coursesList.where((element) => element.teacher.last.image==widget.t.image ||element.teacher.first.image==widget.t.image).toList();
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
      ),        drawer: MainDrawer(),


      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: (Radius.circular(20)))),
                child: ClipRect(
                  child: CachedNetworkImage(
                    imageUrl: EndPoints.ImageUrl + widget.t.image.toString(),
                    imageBuilder: (context, imageProvider) =>
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
              Positioned(
                bottom: 25,
                left: 20,
                child: CustomText(
                  txt: widget.t.name,
                  fontSize: 20,
                ),
              ),

            ],
          ),
          SizedBox(
            height: 10,
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              "qualifications",
              textAlign: TextAlign.left,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.25,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CupertinoColors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 2), color: Colors.blue, blurRadius: 3)
                  ]),child:Center(child:Text(widget.t.qualifications.toString()))
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(onPressed: () {
                if(s==Swith.Courses){
                  setState(() {
                    s=Swith.LiveCourse;
                  });
                }else{
                  s=Swith.Courses;

                }

              },icon: Icon(Icons.live_tv) ,label: CustomText(
                txt: "LiveCourses",
                txtColor: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 18,),),
              Container(
                  child: FlatButton.icon(onPressed: () {
                    setState(() {
                      s=Swith.Courses;
                    });

                  },
                      icon: Icon(Icons.dvr),
                      label: CustomText(txt: "Courses",txtColor: Colors.black,)))
            ],
          ),
    s==Swith.Courses?
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height* 0.75 ,
            width:  MediaQuery
                .of(context)
                .size
                .width,
            child:
            ListView.builder(itemCount:kemo.length,itemBuilder: (context,index){
              if (kemo.length > 0) {
                return

                  InkWell(
                    onTap: (){

                      Get.to( () => CourseDetails(kemo[index].key));
                    },
                    child:
                    CourseListItem(MediaQuery.of(context).size.height * 0.7, MediaQuery.of(context).size.width,
                      kemo[index],"${'EgyptianPound'.tr}",),
                  );
              } else {
                return SizedBox(
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.width * 0.5,
                    child: LogoContainer(
                    ));



              }

            },)

          ): SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.8,
    child: ListView.builder(
    itemCount: _homeCont.liveCoursesList.length,
    scrollDirection: Axis.vertical,
    itemBuilder: (context, index) {
    if(_homeCont.liveCoursesList.length > 0){
    return InkWell(
    onTap: (){
    Get.to(()=> LiveCourseDetails(_homeCont.liveCoursesList[index].key));
    },
    child: LiveCourseListItem( MediaQuery.of(context).size.width, MediaQuery.of(context).size.height * 0.50, _homeCont.liveCoursesList[index],'EgyptianPound'.tr,
    'More'.tr));
    }else{
    return SizedBox(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height * 0.5,
    child: LogoContainer(
    // colors: ConstStyles.DarkColor,
    ));
    }
    },
    ),
    )

        ]
        ,
      )
      ,
    );
  }
}
