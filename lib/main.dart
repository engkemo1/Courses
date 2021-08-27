import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
//import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Pages.dart';
import 'package:troom/Util/ConstStyles.dart';
import 'package:troom/Util/Languague/Translation.dart';
import 'package:troom/View/Home.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: ConstStyles.WhiteColor));
  runApp(
      MyApp(),);
}

class MyApp extends StatelessWidget {
  // GlobalKey _scaffoldkey = GlobalKey();
  @override

  Widget build(BuildContext context) {

    return GetMaterialApp(
      // key: _scaffoldkey,
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.downToUp,
      title: 'Troom',
      theme: ThemeData(
        backgroundColor: ConstStyles.WhiteColor,
        appBarTheme:AppBarTheme(
          backgroundColor: ConstStyles.DarkColor,
          centerTitle: true,
          elevation: 0,
        ),
      ),
      translations: Translation(),
      textDirection: TextDirection.rtl,
      locale:Locale('AR', 'EG'),

     initialRoute: Home.Id,
     getPages: Pages.routes,
    );
  }

}
