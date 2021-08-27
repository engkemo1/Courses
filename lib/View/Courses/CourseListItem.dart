import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:troom/Controller/HomePage/HomeCont.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomNetworkImage.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/Courses/CoursesDataList.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';

class CourseListItem extends StatelessWidget {
  var localH , localW ,egp;
  CoursesDataList item;

  CourseListItem(this.localH, this.localW, this.item,this.egp);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:localW * 0.05,right: localW * 0.05,bottom: localW * 0.01,top: localW * 0.05),
      width: localW,
      height: localH,
      decoration: BoxDecoration(
        color: ConstStyles.WhiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //TODO Image
          SizedBox(
            width: localW,
            height: localH * 0.65,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: localW,
                      height: localH * 0.65,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        image: DecorationImage(
                          image: NetworkImage(
                              EndPoints.ImageUrl + item.image.toString()),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),

                Positioned.fill(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: EdgeInsets.only(left: localW * 0.02, right: localW * 0.015,top: localH * 0.01,bottom: localH * 0.01),
                        margin: EdgeInsets.only(top: localH * 0.1),
                        width: localW * 0.4,
                        height: localH * 0.1,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                        ),
                        child:item.discountPrice == 0 ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoTextSize(
                              text: item.price.toString() + '  ',
                              textColor: ConstStyles.TextColor,
                              size: localW * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        )
                            : Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: localW * 0.2,
                              height: localH * 0.1,
                              child: Stack(
                                fit: StackFit.expand,
                                children: [

                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment
                                          .center,
                                      child: SizedBox(
                                        width: localW * 0.2,
                                        height: localH * 0.1,
                                        child: Center(
                                          child: CustomText(
                                            txtAlign: TextAlign.center,
                                            txt: item.price == null ? '':
                                            item.price.toString(),
                                            txtColor: Colors
                                                .green,
                                            fontSize:
                                            localW *
                                                0.05,
                                          ),
                                        ),
                                      ),),),

                                  Positioned.fill(
                                      child: Align(
                                        alignment: Alignment
                                            .center,
                                        child: SizedBox(
                                          width: localW * 0.15,
                                          height: localH * 0.1,
                                          child: Divider(
                                            thickness: 1,
                                            color: Colors.green,
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                            CustomText(
                              txtAlign: TextAlign.center,
                              txt: item.discountPrice == null ? '':
                              item.discountPrice.toString()
                              ,txtColor: ConstStyles.DarkColor,
                              fontSize: localW * 0.05,),
                            // CustomText(
                            //   txtAlign: TextAlign.center,
                            //   txt: egp
                            //   ,txtColor: ConstStyles.DarkColor,fontSize: localW * 0.05,),
                          ],
                        ),
                      ),
                    ),
                )
              ],
            ),
          ),

          //TODO Course Name
          SizedBox(
            width: localW,
            height: localH * 0.075,
            child: Padding(
              padding:
              EdgeInsets.only(left: localW * 0.02, right: localW * 0.015,top: localH * 0.01,bottom: localH * 0.01),
              child: AutoTextSize(
                text: item.name == null ? '' : item.name,
                textColor: ConstStyles.BlueColor,
                size: localW * 0.07,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //TODO Course Description
          SizedBox(
            width: localW,
            height: localH * 0.085,
            child: Padding(
              padding:
              EdgeInsets.only(left: localW * 0.02, right: localW * 0.015,top: localH * 0.01,bottom: localH * 0.01),
              child: AutoTextSize(
                  text:item.shortDescription ,
                  textColor: ConstStyles.BlackColor,
                  fontWeight: FontWeight.normal,
                  size: localW * 0.035),
            ),
          ),

 /*         //TODO Course Price
          Container(
            padding: EdgeInsets.only(left: localW * 0.02, right: localW * 0.015,top: localH * 0.01,bottom: localH * 0.01),
            width: localW ,
            height: localH * 0.1,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child:item.discountPrice == 0 ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AutoTextSize(
                  text: item.price.toString() + '  ',
                  textColor: ConstStyles.TextColor,
                  size: localW * 0.05,
                  fontWeight: FontWeight.bold,
                ),
                AutoTextSize(
                  text: egp,
                  textColor: ConstStyles.DarkColor,
                  size: localW * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ],
            )
                : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: localW * 0.2,
                  height: localH * 0.1,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [

                      Positioned.fill(
                        child: Align(
                          alignment: Alignment
                              .centerLeft,
                          child: SizedBox(
                            height: localH * 0.1,
                            width: localW * 0.2,
                            child: CustomText(
                              txtAlign: TextAlign.center,
                              txt: item.price == null ? '':
                              item.price.toString(),
                              txtColor: Colors
                                  .green,
                              fontSize:
                              localW *
                                  0.05,
                            ),
                          ),),),

                      Positioned.fill(
                          child: Align(
                            alignment: Alignment
                                .center,
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
                ),
                CustomText(
                    txtAlign: TextAlign.center,
                  txt: item.discountPrice == null ? '':
                item.discountPrice.toString()
                  ,txtColor: ConstStyles.DarkColor,
                fontSize: localW * 0.05,),
                CustomText(
                  txtAlign: TextAlign.center,
                  txt: egp
                  ,txtColor: ConstStyles.DarkColor,fontSize: localW * 0.05,),
              ],
            ),
          ),*/


          Divider(
            thickness: 1,
            color: Colors.grey,
          ),

          //TODO Teacher
          SizedBox(
            width: localW,
            height: localH * 0.13,
            child: ListView.builder(
                itemCount: item.teacher.length,
                itemBuilder: (context,index){
              return SizedBox(
                width: localW,
                height: localH * 0.13,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    //TODO Teacher Image
                    Container(
                      margin: EdgeInsets.only(right: localW * 0.02,left: localW * 0.02,),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                            ConstStyles
                                .WhiteColor,
                            child: GetBuilder<HomeCont>(builder: (_){
                              if(item.teacher.length > 0 && item.teacher[index].image != null){
                                return CustomNetworkImage(url: '${EndPoints.ImageUrl}${item.teacher[index].image}',newImage: (){},radius: 100.0,);
                              }else {
                                return LogoContainer();
                              }
                            },),),
                          //TODO Teacher Name
                          GetBuilder<HomeCont>(builder: (_){
                            if(item.teacher.length > 0){
                              return  SizedBox(
                                // width: localW * 0.25,
                                child: AutoTextSize(
                                  text: item.teacher[index].name == null ? '' : item.teacher[index].name,
                                  textColor: ConstStyles.TextColor,
                                  size: localW * 0.04,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }else {
                              return  CustomText(
                                txt: '',
                                txtColor: ConstStyles.TextColor,
                                fontSize: localW * 0.04,
                              );
                            }

                          }),
                        ],
                      ),
                    ),

                    //TODO Course Level
                    Container(
                      margin: EdgeInsets.only(right: localW * 0.02,left: localW * 0.02,),
                      child: CustomText(
                        txt: item.level == null ? '' : item.level,
                        txtColor: ConstStyles.TextColor,
                        fontSize: localW * 0.04,
                      ),
                    ),

                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );

  }
}
