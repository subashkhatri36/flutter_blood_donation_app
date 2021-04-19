import 'package:get/get.dart';

import '../controllers/myhistory_controller.dart';

class MyhistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyhistoryController>(
      () => MyhistoryController(),
    );
  }
}
