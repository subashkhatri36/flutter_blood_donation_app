import 'package:get/get.dart';

import '../controllers/donation_controller.dart';

class DonationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonationController>(
      () => DonationController(),
    );
  }
}
