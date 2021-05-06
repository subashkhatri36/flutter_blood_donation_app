import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blood_donation_app/app/Widgets/custome_text_field.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';
import 'package:flutter_blood_donation_app/app/utlis/validators.dart';

import 'package:get/get.dart';

import '../controllers/donation_controller.dart';

class DonationView extends GetView<DonationController> {
  final id = Get.arguments;
  @override
  Widget build(BuildContext context) {
    if (id != null) controller.bloodgroup.value = id;
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Donation'),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.all(Defaults.paddingmiddle),
          child: SingleChildScrollView(
            child: Form(
              key: controller.formkey,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      child: Icon(
                        Icons.note,
                        size: 30,
                      ),
                    ),
                    SizedBox(height: Defaults.paddingmiddle),
                    CustomTextField(
                      round: true,
                      hintText: 'To whom you donate blood?',
                      controller: controller.personController,
                      prefixIcon: Icons.account_box,
                      validator: (value) =>
                          validateMinLength(string: value, length: 3),
                    ),
                    SizedBox(height: Defaults.paddingmiddle),
                    CustomTextField(
                        inputformatter: [
                          FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
                          LengthLimitingTextInputFormatter(10),
                          _DateFormatter(),
                        ],
                        round: true,
                        keyboardtype: TextInputType.datetime,
                        hintText: 'Date :01/01/2021',
                        controller: controller.dateController,
                        prefixIcon: Icons.calendar_today,
                        validator: (value) => validateMinMaxLength(
                            string: value, maxLength: 10, minLegth: 10)),
                    SizedBox(height: Defaults.paddingmiddle),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Obx(() => Text(
                              'Blood Type : ${controller.bloodgroup}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Defaults.fontsubheading,
                              ),
                            ))),
                    SizedBox(height: Defaults.paddingmiddle),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          controller.note.value = value;
                        },
                        controller: controller.detailsController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                          prefix: null,
                          prefixIcon: null,
                          hintText: 'Add description',
                          fillColor: Colors.grey,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    SizedBox(height: Defaults.paddingmiddle),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: TextButton(
                          onPressed: () {
                            if (controller.formkey.currentState.validate()) {
                              if (controller.note.value.length > 10) {
                                controller.saveDonation();
                              } else {
                                Get.snackbar('Error !',
                                    'Note must be greater than 10 letters');
                              }
                            }
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(''),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;

    // Get the previous and current input strings
    String pText = prevText.text;
    String cText = currText.text;
    // Abbreviate lengths
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(cText) > 3) {
        // Remove char
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      // Days cannot be greater than 31
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        // Remove char
        cText = cText.substring(0, 1);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if (cLen == 4) {
      // Can only be 0 or 1
      if (int.parse(cText.substring(3, 4)) > 1) {
        // Remove char
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      // Month cannot be greater than 12
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        // Remove char
        cText = cText.substring(0, 4);
      } else {
        // Add a / char
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      // Remove / char
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        // Replace char
        cText = cText.substring(0, 2) + '/';
      } else {
        // Insert / char
        cText =
            cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        // Replace char
        cText = cText.substring(0, 5) + '/';
      } else {
        // Insert / char
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      // Can only be 1 or 2
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      // Can only be 19 or 20
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(
      text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
