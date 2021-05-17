import 'package:get/get.dart';

class NotificationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  String url = 'https://fcm.googleapis.com/fcm/send';
  postnotification() async {
    Map<String, dynamic> headers = {
      'content-type': 'application/json',
      "Authorization":
          "Basic AAAAxUCW8Jg:APA91bGmyvzBzu1kI2KF-s3tKNJMUwKBzMc8-GyJkEF9mrhl1bKidjJxYK4PoBm4n680d3UFLKSAs1VMwUcCjoa6zJrj8e3WTOdPcG6I8af5XUCEKI0Za9vTMMztPqty-rfeq53GJbNx"
    };
    Map<String, dynamic> data = {
      "to":
          "frWxk7neQ46rtSStmXgkYP:APA91bE3ipfvKJC0s46RGWlTmi9H4k34mERECu1NfeJfIYpjtsL--WXaD63bz_3jLFjlE-8I3QxymeJMJKjrYvuknw-Osn6lyo3iJKN8WIZ3uAZRZjbjehoBm3UeKLObchq25J5uaTH8",
      "notification": {
        "body": "This is a Firebase Cloud Messaging Topic Message!",
        "title": "FCM Message"
      }
    };

    await post(url, data, headers: headers);
  }
}
