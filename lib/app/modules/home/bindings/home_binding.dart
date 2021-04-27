import 'package:flutter_blood_donation_app/app/modules/account/controllers/account_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
  }
}
