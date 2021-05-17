import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_blood_donation_app/app/core/model/notificationmodel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:http/http.dart';

class NotificationsController extends GetxController {
  var notificationOn = false.obs;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  getToken() async {
    String token = await messaging.getToken();
    print(token);
    // return token;
  }

  listenMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  // sendNotification() async {
  //  await post('https://fcm.googleapis.com/fcm/send',{});
  // }

//add or rmeove notification notification
  listenNotification() async {
    if (notificationOn.value)
      await messaging.subscribeToTopic('bloodrequest');
    else
      await messaging.unsubscribeFromTopic('bloodrequest');
  }

  ///local notification
  FlutterLocalNotificationsPlugin _flutterLocalNotificationPlugin =
      FlutterLocalNotificationsPlugin();
  var notificationData = List<NotificationData>.empty(growable: true).obs;
  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin =
        FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: false,
            requestSoundPermission: true);
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationPlugin.initialize(initializationSettings);
  }

  Future inistantNotification(int id, String name, String description) async {
    var android = AndroidNotificationDetails(id.toString(), name, description);
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationPlugin.show(id, name, description, platform,
        payload: 'Welcome to Demo app');
  }

  final count = 0.obs;
  @override
  void onInit() {
    initialize();
    listenMessage();

    super.onInit();
    shownotification();
  }

  shownotification() {
    // Timer.periodic(Duration(minutes: 1), ((minutes) async {
    //   var data =
    //       await postRepo.repo.orderBy('timestamp', descending: true).get();
    //   data.docs.forEach((element) {
    //     requests.add(RequestModel.fromDocumentSnapshot(element));
    //   });
    //   if (requests.length != oldrequests.length) {
    //     oldrequests = requests;
    //     oldrequests.forEach((element) {
    //       inistantNotification(i++, ' element.name', '"{element.bloodgroup}"');
    //     });
    //   }
    // inistantNotification(i++, ' element.name', '"{element.bloodgroup}"');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
