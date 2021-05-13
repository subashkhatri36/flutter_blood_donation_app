import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';

import 'package:get/get.dart';

import '../controllers/forgetpassword_controller.dart';

class ForgetpasswordView extends GetView<ForgetpasswordController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: controller.emailValidKey,
              child: Obx(() => controller.sendEmail.isFalse
                  ? Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Enter your email address to reset your password. ',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hintText: 'Email',
                            controller: controller.emailController,
                            prefixIcon: Icons.email,
                            round: true,
                            validator: (value) => validateEmail(string: value),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 20,
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                      borderRadius: 15,
                                      btnColor:
                                          Theme.of(context).backgroundColor,
                                      label: 'Send',
                                      labelColor: Colors.white,
                                      onPressed: () {
                                        controller.resetPassword();
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    )
                  : Container(
                      child: Column(
                        children: [
                          Icon(
                            Icons.email,
                            color: Colors.green,
                            size: 40,
                          ),
                          Text(
                            'Please Check your email for further process.Thank you ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 30.0, right: 30.0, top: 10),
                            child: CustomButton(
                                borderRadius: 15,
                                btnColor: Theme.of(context).backgroundColor,
                                label: 'close',
                                labelColor: Colors.white,
                                onPressed: () {
                                  Get.back();
                                }),
                          ),
                        ],
                      ),
                    )),
            )
          ],
        ),
      ),
    );
  }
}
