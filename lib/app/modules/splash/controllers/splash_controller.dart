import 'dart:async';

import 'package:get/get.dart';

import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../../login/bindings/login_binding.dart';
import '../../login/views/login_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController

  final count = 0.obs;
  var height = 0.0.obs;
  @override
  void onInit() {
    loadPage();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  loadPage() {
    var _duration = Duration(seconds: 0);

    return Timer(_duration, navigate);
  }

  void navigate() {
     Get.off(() => LoginView(),binding: LoginBinding());
   // Get.off(() => HomeView(),binding: HomeBinding());
  }
}
