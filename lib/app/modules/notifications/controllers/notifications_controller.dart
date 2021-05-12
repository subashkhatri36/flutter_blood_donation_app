import 'package:flutter_blood_donation_app/app/core/model/notificationmodel.dart';
import 'package:flutter_blood_donation_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
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
    var android = AndroidNotificationDetails("id", "name", "description");
    var ios = IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: ios);
    await _flutterLocalNotificationPlugin.show(id, name, description, platform,
        payload: 'Welcome to Demo app');
  }

  final count = 0.obs;
  @override
  void onInit() {
    initialize();
    super.onInit();
    shownotification();
    // inistantNotification(1, 'FirebaseDEmo', "description");
  }

  shownotification() {
    userController.requestData.forEach((element) {
      if (element.status == 'waiting')
        inistantNotification(userController.requestData.indexOf(element),
            element.name, "${element.bloodgroup}");
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
