import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/constant/const.dart';
import 'package:flutter_blood_donation_app/app/core/repositories/authentication_repositories.dart';
import 'package:flutter_blood_donation_app/app/modules/home/bindings/home_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  AuthenticationRepo authrepo = new Authentication();

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

  onlineUser() {
    var userId = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (userId != null && userId.isNotEmpty) {
      authrepo.updateUserInfo(userId: userId, fieldname: 'online', value: true);
    }
  }

  void navigate() {
    if (authResult.currentUser != null)
      Get.off(() => HomeView(), binding: HomeBinding());
    else
      Get.off(() => LoginView(), binding: LoginBinding());
  }
}
