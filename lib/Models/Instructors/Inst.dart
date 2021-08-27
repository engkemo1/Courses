
import 'dart:convert';

import 'package:http/http.dart'as http;


import 'package:troom/Models/Instructors/ImstructorsRes.dart';
import 'package:troom/Models/Instructors/InstructorCourses.dart';
import 'package:troom/Models/Instructors/InstructorsDetails.dart';
import 'package:troom/Util/EndPoints.dart';

class InsApi{


Future<List<InstData>> FetchDataInst()async{
  try {
    var url=Uri.parse(EndPoints.Instructors);
   http.Response res=await http.get(url);
   if(res.statusCode==200){
String data=res.body;
var jsonData=json.decode(data);
Data d=Data.fromJson(jsonData);
List<InstData> dataList=
    d.data.map((e) => InstData.fromJson(e)).toList();
return dataList;
   }else
     {
       print("statusCode=${res.statusCode}");
     }


  }catch(e){print(e);}

}

Future<List<InstructorCourses>> FetchDataCourses()async{
  try {
    var url=Uri.parse(EndPoints.InstructorsCourses);
    http.Response res=await http.get(url);
    if(res.statusCode==200){

      var jsonData=json.decode(res.body);
      Courses c = Courses.fromJson(jsonData);
      List<InstructorCourses> courseList=
          c.courses.map((e) =>InstructorCourses.fromJson(e) ).toList();
      return courseList;
    }else
    {
      print("statusCode=${res.statusCode}");
    }


  }catch(e){print(e);}

}

}