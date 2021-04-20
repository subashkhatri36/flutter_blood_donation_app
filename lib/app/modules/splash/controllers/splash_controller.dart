import 'dart:async';

import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
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

  loadPage() {
    var _duration = Duration(seconds: 1);
    return Timer(_duration, navigate);
  }

  void navigate() {
    if (auth.currentUser != null)
      Get.off(() => HomeView(), binding: HomeBinding());
    else
      Get.off(() => LoginView(), binding: LoginBinding());
  }
}
