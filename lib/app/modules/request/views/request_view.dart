import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../login/views/registration_widget.dart';
import '../controllers/request_controller.dart';

class RequestView extends GetView<RequestController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RequestBlood'),
        centerTitle: true,
      ),
      body: ListView(children: [
        Text('Blood Request', style: largeText),
        Text('Our donors help when you need them the most'),
        Row(children: [
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
        Row(children: [
          Text('Find donor near my location'),
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
        Text(
          'Ranibari,Kathmandu',
          style: mediumText,
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
        SizedBox(height: 20),
        Text('Required Blood Group'),
        Container(
            height: 200,
            //   color: Colors.grey,
            child: GridView(
              padding: EdgeInsets.only(top: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20),
              children: [
                CircleAvatar(backgroundColor: Colors.grey, child: Text('A+')),
                CircleAvatar(backgroundColor: Colors.grey, child: Text('A-')),
                CircleAvatar(backgroundColor: Colors.grey, child: Text('B+')),
                CircleAvatar(backgroundColor: Colors.grey, child: Text('B-')),
                CircleAvatar(
                    backgroundColor: Colors.grey, child: Text('AB+')),
                CircleAvatar(
                    backgroundColor: Colors.grey, child: Text('AB-')),
                CircleAvatar(backgroundColor: Colors.grey, child: Text('O+')),
                CircleAvatar(backgroundColor: Colors.grey, child: Text('O-')),
              ],
            )),
        Expanded(child: Container()),
        Text('These Services are free of cost. do not pay anyone')
      ]),
    );
  }
}
