import 'package:get/get.dart';

import '../controllers/bloodgroup_controller.dart';

class BloodgroupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BloodgroupController>(
      () => BloodgroupController(),
    );
  }
}
