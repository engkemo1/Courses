import 'package:get/get.dart';

class ModalHudCont extends GetxController{
  bool isLoading = false;
  String LOGD='ModalHudController';
  changeisLoading(bool vlaue) {
    isLoading = vlaue;
    update();
    print('$LOGD : $isLoading');
  }
}