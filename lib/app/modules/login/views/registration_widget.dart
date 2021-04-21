import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/login/controllers/login_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';
import 'package:get/get.dart';

import '../../../Widgets/CustomButton.dart';
import '../../../Widgets/custome_text_field.dart';

 const largeText = TextStyle(fontSize: 20);
const mediumText = TextStyle(fontSize: 16);
const smallText = TextStyle(fontSize: 12);

class RegistrationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return ListView(
      padding: EdgeInsets.all(Defaults.paddingnormal),
      children: [
        Form(
          key: loginController.signupformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Defaults.paddingmiddle),
              CustomTextField(
                round: true,
                obscureText: false,
                hintText: 'Fullname',
                controller: loginController.nameController,
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
                controller: loginController.emailController,
                validator: (value) => validateEmail(string: value),
              ),
              SizedBox(height: Defaults.paddingmiddle),
              CustomTextField(
                round: true,
                obscureText: false,
                hintText: 'Phone',
                prefixIcon: Icons.phone,
                controller: loginController.phoneController,
                validator: (value) =>
                    validateMinMaxLength(string: value, minLegth: 10),
              ),
              SizedBox(height: Defaults.paddingmiddle),
              CustomTextField(
                round: true,
                obscureText: false,
                hintText: 'Address',
                controller: loginController.addressController,
                prefixIcon: Icons.location_on,
                validator: (value) =>
                    validateMinLength(string: value, length: 3),
              ),
              SizedBox(height: Defaults.paddingmiddle),
              CustomTextField(
                round: true,
                obscureText: true,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                controller: loginController.passwordController,
                validator: (value) => validatePassword(string: value),
              ),
              SizedBox(height: 16),
              CustomTextField(
                round: true,
                obscureText: true,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock,
                controller: loginController.rconformController,
                validator: (value) => confirmPassword(
                    password: loginController.passwordController.text,
                    cPassword: loginController.rconformController.text),
              ),
            ],
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
              if (loginController.signupformKey.currentState.validate()) {
                loginController.register();
                loginController.clearController();
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
