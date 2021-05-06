import 'package:flutter_blood_donation_app/app/modules/account/controllers/account_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/donor_details/controllers/donor_details_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController(), permanent: true);
    Get.lazyPut<AccountController>(
      () => AccountController(),
    );
    Get.lazyPut<DonorDetailsController>(
      () => DonorDetailsController(),
    );
  }
}
