import 'package:flutter/material.dart';
import 'package:troom/CustomViews/AutoTextSize.dart';
import 'package:troom/CustomViews/CustomNetworkImage.dart';
import 'package:troom/CustomViews/CustomText.dart';
import 'package:troom/CustomViews/LogoContainer.dart';
import 'package:troom/Models/LiveCourses/LiveCoursesDataList.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/EndPoints.dart';

class LiveCourseListItem extends StatelessWidget {
  var localH , localW ,egp,more;
  LiveCoursesDataList item;


  LiveCourseListItem(this.localH, this.localW, this.item,this.egp,this.more);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left:localW * 0.05,right: localW * 0.05,bottom: localW * 0.01),
      width: localW,
      height: localH ,
      decoration: BoxDecoration(
        color: ConstStyles.WhiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0xFFA89F9F),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(2.0, 2.0), // shadow direction: bottom right
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        margin: EdgeInsets.all(localW * 0.02),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            AutoTextSize(
                              text: item.price.toString() + '  ',
                              textColor: ConstStyles.TextColor,
                              size: localW * 0.05,
                              fontWeight: FontWeight.bold,
                            ),
                            // AutoTextSize(
                            //   text: egp,
                            //   textColor: ConstStyles.DarkColor,
                            //   size: localW * 0.05,
                            //   fontWeight: FontWeight.bold,
                            // ),
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
              height: localH * 0.09,
              child: CustomText(
                txt: item.name == null ? item.slug : item.name,
                txtColor: ConstStyles.BlueColor,
                fontSize: localW * 0.07,
              ),
            ),

            //TODO Course Description
            SizedBox(
              width: localW,
              height: localH * 0.05,
              child: CustomText(
                  txt:
                  item.shortDescription,
                  txtColor:
                  ConstStyles.BlackColor,
                  fontWeight: FontWeight.normal,
                  fontSize: localW * 0.035),
            ),

            //TODO Course Price
         /*   SizedBox(
              width: localW,
              height: localH *0.08,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                children: [
                  //TODO Price
                  Expanded(
                    child: CustomText(
                      txt: "${item.price.toString()}" + "$egp",
                      txtColor:
                      ConstStyles.BlueColor,
                      fontSize: localW * 0.05,
                    ),
                  ),
                  SizedBox(
                    width: localW * 0.03,
                  ),
                  //TODO Discount Price
                  Expanded(
                    child: item.discountPrice == null ? Container() : Stack(
                      children: [
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment
                                .centerLeft,
                            child: CustomText(
                              txt: item.discountPrice.toString() + '${egp}',
                              txtColor: Colors
                                  .green,
                              fontSize:
                              localW *
                                  0.05,
                            ),),),
                        Positioned.fill(
                            child: Align(
                              alignment: Alignment
                                  .centerLeft,
                              child: SizedBox(
                                width: localW * 0.18,
                                child: Divider(
                                  thickness: 1,
                                  color: Colors.green,
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/

            //TODO Course Date
            SizedBox(
              width: localW * 0.7,
              height: localH * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  //TODO Course Level
                  SizedBox(
                    width: localW * 0.32,
                    child: CustomText(
                        txt: item.category.toString() + ' ' +item.level.toString(),
                        txtColor:
                        ConstStyles.BlackColor,
                        fontWeight: FontWeight.normal,
                        fontSize: localW * 0.035),
                  ),

                  SizedBox(
                    width:localW * 0.3,
                    child: CustomText(
                        txt:item.startTime == null ? ' ' : item.startTime.toString().substring(0,10),
                        txtColor:
                        ConstStyles.BlackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: localW * 0.035),
                  ),
                ],
              ),
            ),


            //TODO Teacher Data
            SizedBox(
              width: localW,
              height: localH * 0.1,
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment
                    .start,
                crossAxisAlignment:
                CrossAxisAlignment.center,
                children: [

                  Expanded(
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor:
                          ConstStyles
                              .WhiteColor,
                          child:item.teacherImg == null ? LogoContainer() :
                          CustomNetworkImage(url: '${EndPoints.ImageUrl}${item.teacherImg}',newImage: (){},radius: 50.0,),
                        ),

                        SizedBox(
                          width: localW * 0.3,
                          child: AutoTextSize(
                            text: item.teacher == null ? '' : item.teacher,
                            textColor:
                            ConstStyles.TextColor,
                            size: localW * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
