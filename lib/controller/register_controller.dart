import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/register_model.dart';
import '../repository/rigister_reposetory.dart';
import '../view/screen/login_page.dart';

class RegisterController extends GetxController {
  final firstNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nationalIDController = TextEditingController();
  final phoneController = TextEditingController();
  final locationCityController = TextEditingController();

  var selectedCity = ''.obs;
  var selectedGender = ''.obs;
  var isLoading = false.obs;

  var avatar = Rxn<XFile>();
  var frontId = Rxn<XFile>();
  var backId = Rxn<XFile>();

  final RegisterRepository _repo = Get.find<RegisterRepository>();

  String getMappedSex(String genderInArabic) {
    if (genderInArabic == 'ذكر') return 'male';
    if (genderInArabic == 'أنثى') return 'female';
    return 'unknown';
  }

  void pickAvatar({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) avatar.value = pickedFile;
  }

  void pickFrontNationalID({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) frontId.value = pickedFile;
  }

  void pickBackNationalID({required ImageSource source}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) backId.value = pickedFile;
  }

  void register() async {
    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("خطأ", "كلمة المرور وتأكيدها غير متطابقين");
      return;
    }

    final request = RegisterRequestModel(
      name: firstNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
      sex: selectedGender.value,
      idNumber: nationalIDController.text.trim(),
      governorate: selectedCity.value,
      city: locationCityController.text.trim(),
      avatar: avatar.value,
      frontId: frontId.value,
      backId: backId.value,
    );

    try {
      final response = await _repo.registerUser(request);

      if (response.statusCode == 200 && response.data['status'] == true) {
        Get.snackbar("نجاح", response.data['message'] ?? "تم التسجيل بنجاح");
        clearForm();
        Future.delayed(Duration(milliseconds: 500), () {
          Get.off(() => LoginPage());
        });
      } else {
        Get.snackbar("خطأ", response.data['message'] ?? "فشل التسجيل");
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print("Response error body: ${e.response!.data}");
      }
      Get.snackbar("خطأ في الاتصال", e.toString());
    }
  }
  void clearForm() {
    firstNameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    nationalIDController.clear();
    phoneController.clear();
    locationCityController.clear();
    selectedCity.value = '';
    selectedGender.value = '';
    avatar.value = null;
    frontId.value = null;
    backId.value = null;
  }

}
