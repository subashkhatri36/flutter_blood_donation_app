import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

import 'package:get/get.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('AccountView'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Theme.of(context).backgroundColor,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(children: [
                            CircleAvatar(
                              radius: 70,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  radius: 68,
                                  backgroundImage: AssetImage(
                                      'assets/images/blooddonation.png')),
                            ),
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).backgroundColor,
                                  radius: 22,
                                  child: Text('A+')),
                            ),
                            Positioned(
                              bottom: 4,
                              right: 2,
                              child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Theme.of(context).backgroundColor,
                                    radius: 16,
                                    child: Icon(Icons.camera),
                                  )),
                            ),
                          ]),
                          SizedBox(height: Defaults.paddingsmall),
                          Text(
                            'Profie Name',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '98XXXXXXXX',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'example@gmail.com',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              icon: Icon(Icons.edit, color: Colors.white),
                              onPressed: () {})
                        ],
                      ),
                    )),
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    color: Colors.yellow,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        Container(
                            width: MediaQuery.of(context).size.width,
                            color: Colors.green,
                            child: Column(
                              children: [
                                Text('Your Rating'),
                                Text('4.5'),
                                Text('AverageRating'),
                                for (int i = 5; i >= 1; i--)
                                  Row(
                                    children: [
                                      Text('$i'),
                                      Icon(Icons.star),
                                      Text('5'),
                                    ],
                                  ),
                                Divider(),
                                Text('Total :')
                              ],
                            )),
                        Card(
                          child: Text('Current Request'),
                        ),
                        CustomButton(
                          borderRadius: 15,
                          btnColor: Theme.of(context).backgroundColor,
                          label: 'Log Out',
                          labelColor: Colors.white,
                          onPressed: () {
                            accountController.signout();
                          },
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
