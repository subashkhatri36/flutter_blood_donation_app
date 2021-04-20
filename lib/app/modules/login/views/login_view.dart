import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_body.dart';
import 'package:flutter_blood_donation_app/app/modules/login/views/login_header_widget.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [LoginHeaderWidget(), Expanded(child: LogInBody())]));
  }
}
