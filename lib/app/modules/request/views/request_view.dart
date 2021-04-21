import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/home/views/home_view.dart';

import 'package:get/get.dart';

import '../../login/views/registration_widget.dart';
import '../controllers/request_controller.dart';

List<String> bloodgroup = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Form(
            key: controller.requestformKey,
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // padding: EdgeInsets.only(left: 20, right: 10, top: 20),
                children: [
                  AppBar(
                    title: Text('RequestBlood'),
                    centerTitle: true,
                  ),
                  Text(
                    'Our donors help when you need them the most',
                    style: mediumText.copyWith(color: Colors.grey[800]),
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(' Request on behalf of friend'),
                    Obx(
                      () => Switch(
                        value: controller.isSwitched.value,
                        onChanged: (value) {
                          controller.isSwitched.value = value;
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text('Find donor near my location'),
                    Obx(
                      () => Switch(
                        value: controller.mylocation.value,
                        onChanged: (value) {
                          controller.mylocation.value = value;
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),
                    ),
                  ]),
                  SizedBox(height: 10),
                  Obx(
                    () => !controller.mylocation.value
                        ? TextFormField(
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.all(8.0),
                                border: UnderlineInputBorder(),
                                labelText: 'Hospital or emergency location'),
                          )
                        : Text(''),
                  ),
                  Obx(
                    () => controller.mylocation.value
                        ? Text(
                            'Ranibari,Kathmandu',
                            style: mediumText,
                          )
                        : Container(),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                        decoration: InputDecoration(
                            hintMaxLines: 3,
                            hintText:
                                'Tell us why and how urgent you\n need blood donor? Give us many details as possible')),
                  ),
                  SizedBox(height: 10),
                  Obx(() => controller.isSwitched.value
                      ? Text('Required Blood Group',
                          style: largeText.copyWith(color: Colors.grey))
                      : const Text('')),
                  SizedBox(height: 10),
                  Obx(() {
                    if (controller.isSwitched.value)
                      return Container(
                          height: 200,
                          //   color: Colors.grey,
                          child: GridView(
                            padding:
                                EdgeInsets.only(top: 10, left: 20, right: 20),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30),
                            children: [
                              for (int i = 0; i < 8; i++)
                                InkWell(
                                  onTap: () {
                                    controller.bloodgroup.value = bloodgroup[i];
                                  },
                                  child: CircleAvatar(
                                      radius: 40,
                                      backgroundColor:
                                          controller.bloodgroup.value ==
                                                  bloodgroup[i]
                                              ? Colors.red
                                              : Colors.grey,
                                      child: Text(
                                        bloodgroup[i],
                                        style: mediumText.copyWith(
                                            color: Theme.of(context)
                                                .scaffoldBackgroundColor),
                                      )),
                                ),
                            ],
                          ));
                    return Container();
                  }),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {
                        if (controller.requestformKey.currentState.validate())
                          print('');
                      },
                      child: Text('Continue'),
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.deepOrange),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'These Services are free of cost. do not pay anyone',
                    style: smallText.copyWith(color: grey),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
