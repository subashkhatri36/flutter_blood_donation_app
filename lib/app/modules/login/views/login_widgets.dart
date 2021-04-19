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
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(Defaults.paddingbig),
        child: Column(
          children: [
            SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              prefixIcon: Icons.email,
              round: true,
              validator: (value) => validateEmail(string: value),
            ),
            SizedBox(height: Defaults.paddingbig),
            CustomTextField(
              hintText: 'Password',
              prefixIcon: Icons.lock,
              round: true,
              validator: (value) => validatePassword(string: value),
            ),
            SizedBox(height: Defaults.paddingbig),
            Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot Password',
                    style: TextStyle(fontWeight: FontWeight.w400))),
            Expanded(child: SizedBox(height: Defaults.paddingbig)),
            Padding(
              padding: const EdgeInsets.all(Defaults.paddingbig),
              child: CustomButton(
                btnColor: Colors.deepOrange,
                label: 'LOGIN',
                labelColor: Colors.white,
                onPressed: () {
                  if (loginController.loginformKey.currentState.validate())
                    loginController.login();
                },
              ),
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
    );
  }
}
