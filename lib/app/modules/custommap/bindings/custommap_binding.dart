import 'package:get/get.dart';

import '../controllers/custommap_controller.dart';

class CustommapBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustommapController>(
      () => CustommapController(),
    );
  }
}
