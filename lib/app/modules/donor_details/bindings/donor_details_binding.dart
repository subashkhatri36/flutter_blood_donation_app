import 'package:get/get.dart';

import '../controllers/donor_details_controller.dart';

class DonorDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DonorDetailsController>(
      () => DonorDetailsController(),
    );
  }
}
