import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/notification_model.dart';

class NotificationController extends GetxController {
  final box = GetStorage();
  final notifications = <MyNotification>[].obs;

  static const String storageKey = 'stored_notifications';

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void addNotification(MyNotification notification) {
    notifications.insert(0, notification);
    saveNotifications();
  }

  void markAsRead(int index) {
    notifications[index].isRead = true;
    notifications.refresh();
    saveNotifications();
  }

  void saveNotifications() {
    final jsonList = notifications.map((e) => e.toJson()).toList();
    box.write(storageKey, jsonList);
  }

  void loadNotifications() {
    final jsonList = box.read(storageKey);
    if (jsonList != null) {
      notifications.value = List<MyNotification>.from(
        (jsonList as List).map((e) => MyNotification.fromJson(e)),
      );
    }
  }

  void clearAll() {
    notifications.clear();
    box.remove(storageKey);
  }
}
