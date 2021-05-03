import 'package:get/get.dart';

import '../controllers/view_all_reviews_controller.dart';

class ViewAllReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ViewAllReviewsController>(
      () => ViewAllReviewsController(),
    );
  }
}
