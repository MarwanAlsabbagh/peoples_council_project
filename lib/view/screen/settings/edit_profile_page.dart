// lib/pages/edit_profile_page.dart
import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("تعديل الملف الشخصي")),
      body: const Center(child: Text("صفحة تعديل الملف الشخصي")),
    );
  }
}
