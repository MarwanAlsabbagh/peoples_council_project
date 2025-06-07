import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  final controller = Get.find<NotificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("الإشعارات")),

      body: Obx(() {
        if (controller.notifications.isEmpty) {
          return const Center(child: Text("لا توجد إشعارات بعد"));
        }

        return ListView.separated(
          itemCount: controller.notifications.length,
          separatorBuilder: (context, index) => Divider(height: 1, color: Colors.grey[300]),
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];

            return Container(
              color: notif.isRead ? Colors.white : Colors.grey[200],
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                title: Text(
                  notif.title,
                  style: TextStyle(
                    color: const Color(0xff2E8F5A),
                    fontWeight: notif.isRead ? FontWeight.normal : FontWeight.bold,
                  ),
                  textAlign: TextAlign.right,
                ),
                subtitle: Text(
                  notif.body,
                  textAlign: TextAlign.right,
                ),
                leading:Text(
                  DateFormat('yyyy/MM/dd – HH:mm').format(notif.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                onTap: () => controller.markAsRead(index),
              ),
            );
          },
        );
      }),
    );
  }
}
