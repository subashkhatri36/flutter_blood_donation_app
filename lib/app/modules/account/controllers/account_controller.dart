import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blood_donation_app/app/modules/login/bindings/login_binding.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_view.dart';
import 'package:get/get.dart';

class AccountController extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  void signout() {
    FirebaseAuth.instance.signOut();
    Get.offAll(() => LoginView(), binding: LoginBinding());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
