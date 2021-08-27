import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:troom/Controller/ModalHudCont.dart';
import 'package:troom/Models/AboutUs/AboutUsRes.dart';
import 'package:troom/Models/AboutUs/AboutUsResData.dart';
import 'package:troom/Models/Footer/FooterRes.dart';
import 'package:troom/Models/Footer/FooterResData.dart';
import 'package:troom/Repo/AboutUsRepo.dart';
import 'package:troom/Util/LocalDataStrings.dart';

class AboutUsCont extends GetxController{
  String LOGD = 'AboutUsCont-->';
  final ModalHudCont modalHudController = Get.put(ModalHudCont());
   AboutUsRepo _repo;
   AboutUsResData aboutUsResData = AboutUsResData();
   FooterResData footerResData = FooterResData();
   var getStorage,appLang ;

  @override
  void onInit() {
    // TODO: implement onInit
    _repo = AboutUsRepo();
    getStorage = GetStorage();
    super.onInit();
  }

  @override
  void onReady() async{
    // TODO: implement onReady
    appLang = await getStorage.read(LocalDataStrings.appLanguage);
    if(appLang == null ){
      appLang = 'ar';
      getStorage.write(LocalDataStrings.appLanguage,'ar');
      update();
    }
     getAboutUsData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });

    await getFooterData().whenComplete(() {
      modalHudController.changeisLoading(false);
      update();
    });
    super.onReady();
  }

  Future<bool> getAboutUsData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.aboutUs(appLang.toString()).then((value) {
      AboutUsRes analysisRes = AboutUsRes.fromJson(value.data);
      if (analysisRes.status){
        aboutUsResData = AboutUsResData.fromJson(analysisRes.data.toJson());
        update();
        print('$LOGD getAboutUsData  Name ${aboutUsResData.name}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

  Future<bool> getFooterData()async{
    modalHudController.changeisLoading(true);
    var res = await _repo.footer().then((value) {
      FooterRes footerRes = FooterRes.fromJson(value.data);
      if (footerRes.status){
        footerResData = FooterResData.fromJson(footerRes.data.toJson());
        update();
        print('$LOGD getFooterData  Name ${aboutUsResData.name}');
        return true;
      }else{
        return false;
      }
    });

    return res;
  }

}