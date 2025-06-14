import 'package:final_senior_project/view/screen/settings/edit_profile_page.dart';
import 'package:final_senior_project/view/screen/settings/privacy_policy_page.dart';
import 'package:final_senior_project/view/screen/settings/terms_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../controller/login_controller.dart';
import '../../../utils/media_utils.dart'; // تأكد أن دالة getFullMediaUrl هنا
import '../../widgets/custom_app_bar.dart';
import '../../widgets/logout_dialog.dart';
import 'help_center_page.dart';
import 'language_page.dart';

class SettingPage extends StatelessWidget {
  SettingPage({super.key});

  final LoginController authController = Get.find<LoginController>();
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    final user = box.read('user') ?? {};
    final String name = user['name'] ?? 'اسم غير معروف';
    final String email = user['email'] ?? 'بريد إلكتروني غير معروف';
    final String? imagePath = user['image'];
    final String imageUrl = getFullMediaUrl(imagePath);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(imageUrl),
                      onBackgroundImageError: (_, __) {
                        // ممكن تضيف صورة افتراضية لو حصل خطأ في تحميل الصورة
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      email,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
              const ListTile(
                title: Text(
                  'الإعدادات العامة :',
                  style: TextStyle(
                    color: Color(0xfff2E8F5A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('تعديل معلومات الملف الشخصي'),
                onTap: () => Get.to(EditProfilePage()),
              ),
              const ListTile(
                leading: Icon(Icons.notifications),
                title: Text('الإشعارات'),
                trailing: Text('مفعّلة'),
              ),
              ListTile(
                leading: const Icon(Icons.language),
                title: const Text('اللغة'),
                trailing: const Text('العربية'),
                onTap: () => Get.to(const LanguagePage()),
              ),
              const ListTile(
                title: Text(
                  'قسم المساعدة :',
                  style: TextStyle(
                    color: Color(0xfff2E8F5A),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.privacy_tip),
                title: const Text('السياسة والخصوصية'),
                onTap: () => Get.to(const PrivacyPolicyPage()),
              ),
              ListTile(
                leading: const Icon(Icons.rule),
                title: const Text('الشروط والأحكام'),
                onTap: () => Get.to(const TermsPage()),
              ),
              ListTile(
                leading: const Icon(Icons.help_center),
                title: const Text('مركز المساعدة'),
                onTap: () => Get.to(const HelpCenterPage()),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'تسجيل خروج',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () => LogoutDialogWidget.show(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
