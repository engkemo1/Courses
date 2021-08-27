import 'package:get/get.dart';
import 'package:troom/Controller/ContactUs/ContactUsCont.dart';

class ContactUsBinding extends Bindings{
  @override
  void dependencies() {
    Get.put(ContactUsCont(), permanent: true);
  }
}