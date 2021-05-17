import 'dart:io';

import 'package:get/get.dart';

class NotificationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  static const key =
      "Bearer AAAAxUCW8Jg:APA91bGmyvzBzu1kI2KF-s3tKNJMUwKBzMc8-GyJkEF9mrhl1bKidjJxYK4PoBm4n680d3UFLKSAs1VMwUcCjoa6zJrj8e3WTOdPcG6I8af5XUCEKI0Za9vTMMztPqty-rfeq53GJbNx";
  String url = 'https://fcm.googleapis.com/fcm/send';
  postnotification(
      String token, String userName, String bloodgroup, String address) async {
    Map<String, dynamic> data = {
      "to": token,
      "notification": {
        "body": "Urgent!!! $userName requires $bloodgroup blood on $address!",
        "title": "Blood Required"
      }
    };
    // var response =
    await post(url, data, headers: {HttpHeaders.authorizationHeader: key});

    //print(response.statusText);
  }
}
