import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      /// For iOS request permission first.
      _firebaseMessaging.requestPermission();
      NotificationSettings settings =
          await _firebaseMessaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      _firebaseMessaging.setForegroundNotificationPresentationOptions(
          alert: true, badge: true, sound: false);
    }

    /// For testing purposes print the Firebase Messaging token
    String token = await _firebaseMessaging.getToken();
    print("FirebaseMessaging token: $token");
    _initialized = true;
    handlePushNotificationMessageEvents();
    handlePushNotificationOpenedEvents();
  }

  /// handle push notification events on received
  void handlePushNotificationMessageEvents() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = notification?.android;
      AppleNotification apple = notification?.apple;
      print(message.data);
      print(notification.title);
      print(notification.body);
      if (notification != null && android != null) {
        // do operation for android
      }
      if (notification != null && apple != null) {
        // do operation for ios
      }
    });
  }

  /// handle push notification events on tapped
  void handlePushNotificationOpenedEvents() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = notification?.android;
      AppleNotification apple = notification?.apple;
      print(message.data);
      print(notification.title);
      print(notification.body);
      if (notification != null && android != null) {
        // do operation for android
      }
      if (notification != null && apple != null) {
        // do operation for ios
      }
    });
  }
}
