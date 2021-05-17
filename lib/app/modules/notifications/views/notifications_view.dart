import 'package:flutter/material.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_blood_donation_app/app/modules/notifications/providers/notification_provider.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
//	AAAAxUCW8Jg:APA91bGmyvzBzu1kI2KF-s3tKNJMUwKBzMc8-GyJkEF9mrhl1bKidjJxYK4PoBm4n680d3UFLKSAs1VMwUcCjoa6zJrj8e3WTOdPcG6I8af5XUCEKI0Za9vTMMztPqty-rfeq53GJbNx

  @override
  Widget build(BuildContext context) {
    // controller.inistantNotification(1, 'Sudarhsan', 'MEssage');
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationsView'),
        centerTitle: true,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            // NotificationProvider()
            //     .postnotification(userController.myinfo.value.fcmtoken);
          },
          child: Text(
            'Notification list',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
