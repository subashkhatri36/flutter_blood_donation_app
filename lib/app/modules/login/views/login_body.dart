import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_widgets.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/registration_widget.dart';
import 'package:get/get.dart';

class LogInBody extends StatelessWidget {
  const LogInBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return PageView.builder(
      physics: new NeverScrollableScrollPhysics(),
      // physics: BouncingScrollPhysics(),
      controller: loginController.pageviewScroll,
      itemCount: 2,
      itemBuilder: (context, position) {
        return Form(
          key: loginController.loginformKey,
          child: Obx(() => loginController.currentpage.value == 0
              ? LoginWidgets()
              : RegistrationWidget()),
        );
      },
    );
  }
}
