import 'package:get/get.dart';

import '../controllers/updateaccount_controller.dart';

class UpdateaccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateaccountController>(
      () => UpdateaccountController(),
    );
  }
}
