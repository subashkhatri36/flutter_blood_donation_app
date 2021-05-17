import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetpasswordController extends GetxController {
  RxBool sendEmail = false.obs;
  GlobalKey<FormState> emailValidKey = new GlobalKey<FormState>();
  TextEditingController emailController = new TextEditingController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> resetPassword() async {
    try {
      if (emailValidKey.currentState.validate()) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text);
        sendEmail.toggle();
      } else {
        Get.snackbar('Error!', 'Something Went Wrong Please Try Again !');
      }
    } catch (err) {
      Get.snackbar('Error!', err.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
