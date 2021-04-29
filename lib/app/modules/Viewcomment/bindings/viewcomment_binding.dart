import 'package:get/get.dart';

import '../controllers/viewcomment_controller.dart';

class ViewcommentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewcommentController>(
      () => ViewcommentController(),
    );
  }
}
