import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';
import 'package:get/get.dart';

class RegistrationWidget extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(Defaults.paddingnormal),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Fullname',
                  prefixIcon: Icons.account_box,
                  validator: (value) =>
                      validateMinLength(string: value, length: 3),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  validator: (value) => validateEmail(string: value),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: false,
                  hintText: 'Phone',
                  prefixIcon: Icons.phone,
                  validator: (value) =>
                      validateMinMaxLength(string: value, minLegth: 10),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  validator: (value) => validatePassword(string: value),
                ),
                SizedBox(height: 16),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  validator: (value) => confirmPassword(
                      password: loginController.passwordController.text,
                      cPassword: value),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: CustomButton(
            borderRadius: 15,
            btnColor: Colors.deepOrange,
            label: 'REGISTER',
            labelColor: Colors.white,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                loginController.register();
              }
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already hava account "),
            InkWell(
              onTap: () {
                if (loginController.currentpage.value == 0) {
                  loginController.currentpage.value = 1;
                } else {
                  loginController.currentpage.value = 0;
                }
                loginController.jumppage(context);
              },
              child: Text(" Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
            )
          ],
        ),
        SizedBox(height: Defaults.paddingnormal),
      ],
    );
  }
}
