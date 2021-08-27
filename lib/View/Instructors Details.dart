import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/Courses/CoursesDataList.dart';
import 'package:troom/Models/Instructors/Inst.dart';
import 'package:troom/Models/Instructors/InstructorsDetails.dart';
import 'package:troom/Util/EndPoints.dart';
import 'package:troom/View/Courses/CourseListItem.dart';

import 'Courses/CourseDetails.dart';

class InstructorScreen extends StatelessWidget {
  InstData t;

  InstructorScreen({this.t});

  InsApi a = InsApi();


  final HomeCont _homeCont = Get.put(HomeCont());


  @override
  Widget build(BuildContext context) {
    List<CoursesDataList> kemo=_homeCont.coursesList.where((element) =>element.image==t.image).toList();
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: (Radius.circular(20)))),
                child: ClipRect(
                  child: CachedNetworkImage(
                    imageUrl: EndPoints.ImageUrl + t.image.toString(),
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
                  txt: t.name,
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
                  ]),child:Center(child:Text(t.qualifications.toString()))
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton.icon(onPressed: () {


              },icon: Icon(Icons.live_tv) ,label: CustomText(
                txt: "LiveCourses",
                txtColor: Colors.green,
                fontWeight: FontWeight.w400,
                fontSize: 18,),),
              Container(
                  child: FlatButton.icon(onPressed: () {},
                      icon: Icon(Icons.dvr),
                      label: CustomText(txt: "Courses",txtColor: Colors.black,)))
            ],
          ),

          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height* 0.75 ,
              width:  MediaQuery
                  .of(context)
                  .size
                  .width,
              child:ListView.builder(itemCount:kemo.length,itemBuilder: (context,index){
                if (kemo.length > 0) {
                  return

                    InkWell(
                      onTap: (){

                        Get.to( () => CourseDetails(kemo[index].key));
                      },
                      child:
                      CourseListItem(MediaQuery.of(context).size.height * 0.7, MediaQuery.of(context).size.width,
                          kemo[index],"${'EgyptianPound'.tr}"),
                    );
                } else {
                  return SizedBox(
                      width: MediaQuery.of(context).size.height,
                      height: MediaQuery.of(context).size.width * 0.5,
                      child: LogoContainer(
                      ));
                }


              })

          ),

        ]
        ,
      )
      ,
    );
  }
}
