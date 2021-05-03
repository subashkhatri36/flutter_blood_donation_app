import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

import 'package:flutter_blood_donation_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';
import 'package:get/get.dart';

class LoginWidgets extends StatelessWidget {
  const LoginWidgets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * .6,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Form(
            key: loginController.loginformKey,
            child: Column(
              children: [
                SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Email',
                  controller: loginController.emailController,
                  prefixIcon: Icons.email,
                  round: true,
                  validator: (value) => validateEmail(string: value),
                ),
                SizedBox(height: Defaults.paddingbig),
                CustomTextField(
                  hintText: 'Password',
                  obscureText: true,
                  prefixIcon: Icons.lock,
                  controller: loginController.passwordController,
                  round: true,
                  validator: (value) => validatePassword(string: value),
                ),
                SizedBox(height: Defaults.paddingbig),
                Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password',
                        style: TextStyle(fontWeight: FontWeight.w400))),
                SizedBox(
                  height: Defaults.paddingbig,
                ),
                Obx(() => loginController.loginProcess.value
                    ? Container(
                        height: Defaults.paddingbig * 2,
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    : Container()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: CustomButton(
                    borderRadius: 15,
                    btnColor: Theme.of(context).backgroundColor,
                    label: 'Login',
                    labelColor: Colors.white,
                    onPressed: () {
                      if (loginController.loginformKey.currentState
                          .validate()) {
                        if (!loginController.loginProcess.value) {
                          loginController.loginProcess.value = true;
                          loginController.login();
                        }
                        // loginController.clearController();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: Defaults.paddingmiddle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account "),
                    InkWell(
                      onTap: () {
                        if (loginController.currentpage.value == 0) {
                          loginController.currentpage.value = 1;
                        } else {
                          loginController.currentpage.value = 0;
                        }
                        loginController.jumppage(context);
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    )
                  ],
                ),
                SizedBox(height: Defaults.borderRadius),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
