import 'package:final_senior_project/view/screen/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../models/user_login.dart';
import '../repository/login_repository.dart';
import '../view/screen/notification_page.dart';
import '../view/widgets/bottom-navigation_bar.dart';
import '../view/widgets/buttom_ellection_nav_bar.dart';
import '../view/widgets/debuty_boyyom_nav_bar.dart';

class LoginController extends GetxController {
  final LoginRepository authRepository = Get.find<LoginRepository>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields", snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading.value = true;

    UserLogin user = UserLogin(
      email: emailController.text,
      password: passwordController.text,
    );

    try {
      bool success = await authRepository.login(user);
      if (success) {
        final box = GetStorage();
        final role = box.read('role');

        if (role == 'CandidateDetail') {
          Get.offAll(() => DebutyBottomNavigationBar());
        } else if (role == 'Citizen') {

          //Get.offAll(() => UserBottomNavigationBar());
          Get.offAll(() => BottomEllectionNavBar());
        } else {
          Get.snackbar("Error", "Unknown role", snackPosition: SnackPosition.BOTTOM);
        }

        Get.snackbar("Success", "Login successful", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Invalid credentials", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }

    isLoading.value = false;
  }

  Future<void> logout() async {
    try {
      bool success = await authRepository.logout();
      if (success) {
        Get.offAll(LoginPage());
        Get.snackbar("Success", "Logout successful", snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("Error", "Logout failed", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}