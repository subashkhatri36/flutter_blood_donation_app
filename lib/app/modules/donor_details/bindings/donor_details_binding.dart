import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

import '../controllers/donor_details_controller.dart';

class DonorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonorDetailsController>(
      () => DonorDetailsController(),
    );
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
