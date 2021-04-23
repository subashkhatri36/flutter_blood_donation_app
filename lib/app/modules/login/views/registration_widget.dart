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

class RegistrationWidget extends StatefulWidget {
  @override
  _RegistrationWidgetState createState() => _RegistrationWidgetState();
}

class _RegistrationWidgetState extends State<RegistrationWidget> {
  bool selectedState = false;
  String selectedData = '';
  @override
  Widget build(BuildContext context) {
    final loginController = Get.find<LoginController>();
    return Container(
      padding: EdgeInsets.all(Defaults.paddingnormal),
      child: SingleChildScrollView(
        child: Form(
            key: loginController.signupformKey,
            child: Column(
              children: [
                CustomTextField(
                  round: true,
                  hintText: 'Fullname',
                  controller: loginController.nameController,
                  prefixIcon: Icons.account_box,
                  validator: (value) =>
                      validateMinLength(string: value, length: 3),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  hintText: 'Email',
                  prefixIcon: Icons.email,
                  controller: loginController.remailController,
                  validator: (value) => validateEmail(string: value),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
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
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: EdgeInsets.only(left: Defaults.paddingbig),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Defaults.paddingbig),
                        border: Border.all(color: Colors.grey[600])),
                    child: DropdownButton<String>(
                      isExpanded: true,

                      value: loginController.bloodgroup.value.isEmpty
                          ? 'your blood group'
                          : loginController.bloodgroup.value,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.grey[600],
                      ),
                      iconSize: 30, //this inicrease the size
                      elevation: 16,

                      style: TextStyle(color: Colors.grey[600]),
                      underline: Container(),
                      onChanged: (String newValue) {
                        loginController.bloodgroup.value = newValue;
                        selectedData = newValue;
                        selectedState = true;
                      },
                      items: loginController.bloodgouplist
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(color: Colors.grey[600]),
                              textAlign: TextAlign.center),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Password',
                  prefixIcon: Icons.lock,
                  controller: loginController.rpasswordController,
                  validator: (value) => validatePassword(string: value),
                ),
                SizedBox(height: Defaults.paddingmiddle),
                CustomTextField(
                  round: true,
                  obscureText: true,
                  hintText: 'Confirm Password',
                  prefixIcon: Icons.lock,
                  controller: loginController.rconformController,
                  validator: (value) => confirmPassword(
                      password: loginController.rpasswordController.text,
                      cPassword: loginController.rconformController.text),
                ),
                SizedBox(height: Defaults.paddingnormal),
                Obx(() => loginController.loginProcess.value
                    ? Container(
                        height: Defaults.paddingbig * 2,
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).backgroundColor,
                        ),
                      )
                    : Container()),
                SizedBox(height: Defaults.paddingnormal),
                CustomButton(
                  borderRadius: 15,
                  btnColor: Theme.of(context).backgroundColor,
                  label: 'REGISTER',
                  labelColor: Colors.white,
                  onPressed: () {
                    if (loginController.signupformKey.currentState.validate()) {
                      if (selectedState && selectedData != 'your blood group') {
                        if (!loginController.loginProcess.value) {
                          loginController.loginProcess.value = true;
                          loginController.register();
                        } else {
                          Get.snackbar('Warning!',
                              'Blood group is not selected\n Please Select blood Group.');
                        }
                      } else
                        Get.snackbar('Warning!',
                            'Blood group is not selected\n Please Select blood Group.');
                      // loginController.clearController();
                    }
                  },
                ),
                SizedBox(height: Defaults.paddingnormal),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already hava account"),
                    InkWell(
                      onTap: () {
                        if (loginController.currentpage.value == 0) {
                          loginController.currentpage.value = 1;
                        } else {
                          loginController.currentpage.value = 0;
                        }
                        loginController.jumppage(context);
                      },
                      child: Text("Login",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor)),
                    )
                  ],
                ),
                SizedBox(height: Defaults.paddingnormal),
              ],
            )),
      ),
    );
  }
}
