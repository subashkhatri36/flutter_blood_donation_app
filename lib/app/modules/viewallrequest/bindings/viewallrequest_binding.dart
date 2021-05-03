import 'package:get/get.dart';

import '../controllers/viewallrequest_controller.dart';

class ViewallrequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewallrequestController>(
      () => ViewallrequestController(),
    );
  }
}
