import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/Widgets/CustomButton.dart';
import 'package:flutter_blood_donation_app/app/constant/defaults.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
                child: AccountHeaderWidget(),
              ),
              Expanded(
                  flex: 6,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        RatingWidget(),
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

class AccountHeaderWidget extends StatelessWidget {
  const AccountHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    print(accountController.model.toString());
    print(accountController.loadigUserData.value);
    return Obx(() => accountController.loadigUserData.isTrue
        ? Container(
            child: CircularProgressIndicator(),
          )
        : Container(
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
                          child: accountController.isImageUploading.isTrue
                              ? Center(child: CircularProgressIndicator())
                              : Text(''),
                          backgroundImage: accountController
                                  .isImageNetwork.value
                              ? NetworkImage(accountController.userImage.value)
                              : accountController.image != null
                                  ? FileImage(
                                      accountController.image,
                                    )
                                  : AssetImage(
                                      'assets/images/logo.PNG',
                                    )),

                      //  accountController.model.photoUrl !=
                      //         null
                      //     ? AssetImage('assets/images/blooddonation.png')
                      // //     : NetworkImage(accountController.model.photoUrl)
                      //     ),
                    ),
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                          backgroundColor: Theme.of(context).backgroundColor,
                          radius: 22,
                          child: Text(accountController.model.bloodgroup)),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 2,
                      child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).backgroundColor,
                            radius: 16,
                            child: IconButton(
                              icon: Icon(
                                Icons.camera,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: () {
                                accountController.getImage(true);
                              },
                            ),
                          )),
                    ),
                  ]),
                  SizedBox(height: Defaults.paddingsmall),
                  Text(
                    accountController.model.username,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    accountController.model.phoneNo,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    accountController.model.email,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      icon: Icon(Icons.edit, color: Colors.white),
                      onPressed: () {})
                ],
              ),
            )));
  }
}

class RatingWidget extends StatelessWidget {
  const RatingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    return Card(
      margin: EdgeInsets.all(Defaults.paddingnormal),
      child: Obx(() => accountController.loadigUserData.isTrue
          ? Container(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              margin: EdgeInsets.all(Defaults.paddingbig),
              padding: EdgeInsets.all(Defaults.paddingbig),
              child: Column(
                children: [
                  Text('Your Rating Overview',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading)),
                  SizedBox(
                    height: Defaults.paddingsmall,
                  ),
                  Obx(() => Text(
                        accountController.average.value.toStringAsFixed(2),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Defaults.fontheading * 2),
                      )),
                  Text(
                    'Average Rating',
                  ),
                  SizedBox(
                    height: Defaults.paddingsmall,
                  ),
                  for (int i = 5; i >= 1; i--)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            flex: 1,
                            child:
                                Text(i.toString(), textAlign: TextAlign.right)),
                        Expanded(flex: 2, child: Icon(Icons.star)),
                        Expanded(
                          flex: 7,
                          child: LinearPercentIndicator(
                            lineHeight: 5.0,
                            percent: accountController.showpercentage(i),
                            backgroundColor: Colors.grey,
                            progressColor: progressColor(i, context),
                          ),
                        )
                      ],
                    ),
                  Divider(),
                  Text('Total : ${accountController.total.value}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.fontheading))
                ],
              ),
            )),
    );
  }
}

Color progressColor(int i, BuildContext context) {
  switch (i) {
    case 1:
      return Theme.of(context).backgroundColor;
      break;
    case 2:
      return Colors.deepOrange;
      break;
    case 3:
      return Colors.yellow;
      break;
    case 4:
      return Colors.green[300];
      break;
    case 5:
      return Colors.green[900];
      break;
    case 6:
      return Colors.deepPurple;
      break;
    default:
      return Colors.blue[900];
      break;
  }
}
