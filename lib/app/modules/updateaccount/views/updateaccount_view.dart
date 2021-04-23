import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/modules/account/controllers/account_controller.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';

import 'package:get/get.dart';

import '../controllers/updateaccount_controller.dart';

class UpdateaccountView extends GetView<UpdateaccountController> {
  final model = Get.arguments;
  final mcontroller = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    controller.loading(model);
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Acount'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(Defaults.borderRadius),
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  CustomTextField(
                    round: true,
                    hintText: 'Fullname',
                    controller: controller.nameController,
                    prefixIcon: Icons.account_box,
                    validator: (value) =>
                        validateMinLength(string: value, length: 3),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                  CustomTextField(
                    round: true,
                    hintText: 'Phone',
                    prefixIcon: Icons.phone,
                    controller: controller.poneController,
                    validator: (value) =>
                        validateMinMaxLength(string: value, minLegth: 10),
                  ),
                  SizedBox(height: Defaults.paddingmiddle),
                 // Obx(() => Text(controller.mylatitude.value.toString())),
                  SizedBox(height: Defaults.paddingmiddle),
                  CustomTextField(
                    round: true,
                    obscureText: false,
                    hintText: 'Address',
                    controller: controller.addressController,
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

                        value: controller.bloodgroup.value.isEmpty
                            ? 'your blood group'
                            : controller.bloodgroup.value,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey[600],
                        ),
                        iconSize: 30, //this inicrease the size
                        elevation: 16,

                        style: TextStyle(color: Colors.grey[600]),
                        underline: Container(),
                        onChanged: (String newValue) {
                          controller.bloodgroup.value = newValue;
                          controller.selectedData = newValue;
                          controller.selectedstate = true;
                        },
                        items: controller.bloodgouplist
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
                  SizedBox(height: Defaults.paddingnormal),
                  Obx(() => controller.updateState.value
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
                    label: 'Update',
                    labelColor: Colors.white,
                    onPressed: () async {
                      if (controller.formKey.currentState.validate()) {
                        if (controller.selectedstate &&
                            controller.selectedData != 'your blood group') {
                          if (!controller.updateState.value) {
                            controller.updateState.value = true;
                            bool body = await controller.updateProfile();
                            if (body) { 
                              controller.updateState.value = false;
                              mcontroller.model.phoneNo =
                                  controller.poneController.text;

                              mcontroller.model.userAddress =
                                  controller.addressController.text;

                              mcontroller.model.username =
                                  controller.nameController.text;

                              mcontroller.model.bloodgroup =
                                  controller.bloodgroup.value;
                              mcontroller.backfromupdate.toggle();
                            }
                          } else {
                            Get.snackbar('Warning!',
                                'Blood group is not selected\n Please Select blood Group.',
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        } else
                          Get.snackbar('Warning!',
                              'Blood group is not selected\n Please Select blood Group.',
                              snackPosition: SnackPosition.BOTTOM);
                        // loginController.clearController();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
