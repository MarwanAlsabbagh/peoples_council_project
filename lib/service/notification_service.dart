import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../controller/notification_controller.dart';
import '../models/notification_model.dart';

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final initSettings = InitializationSettings(android: android);
    await _localNotifications.initialize(initSettings);

    NotificationSettings settings = await _messaging.requestPermission();

    // إشعار أثناء فتح التطبيق
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      final notification = message.notification;
      if (notification != null) {
        _showLocalNotification(notification);
        Get.find<NotificationController>().addNotification(
          MyNotification(
            title: notification.title ?? '',
            body: notification.body ?? '',
            date: DateTime.now(),
          ),
        );
      }
    });

    // عند فتح التطبيق من إشعار
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        Get.find<NotificationController>().addNotification(
          MyNotification(
            title: notification.title ?? '',
            body: notification.body ?? '',
            date: DateTime.now(),
          ),
        );
      }
    });

    // إذا تم فتح التطبيق من إشعار وكان مغلق تمامًا
    RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      final notification = initialMessage.notification;
      if (notification != null) {
        Get.find<NotificationController>().addNotification(
          MyNotification(
            title: notification.title ?? '',
            body: notification.body ?? '',
            date: DateTime.now(),
          ),
        );
      }
    }
  }

  static Future<void> _showLocalNotification(RemoteNotification notification) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const platformDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      0,
      notification.title,
      notification.body,
      platformDetails,
    );
  }
}
