import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:dio/dio.dart' as dio; // ❌ لا حاجة لها مؤقتاً إن لم تستخدم OCR
// import 'package:path/path.dart';       // ❌ مستخدم فقط في OCR

import '../models/register_model.dart';
import '../repository/rigister_reposetory.dart';

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

  var avatar = Rxn<XFile>();
  var frontId = Rxn<XFile>();
  var backId = Rxn<XFile>();

  final RegisterRepository _repo = RegisterRepository();

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

  // ---------------------------- OCR METHOD (DISABLED) ----------------------------

  // Future<String?> extractIdFromBackId(XFile backIdImage) async {
  //   final dio.Dio dioClient = dio.Dio();

  //   try {
  //     final formData = dio.FormData.fromMap({
  //       'image': await dio.MultipartFile.fromFile(
  //         backIdImage.path,
  //         filename: basename(backIdImage.path),
  //       ),
  //     });

  //     final response = await dioClient.post(
  //       'http://127.0.0.1:5000/ocr', // استبدل هذا بالرابط الصحيح
  //       data: formData,
  //       options: dio.Options(
  //         headers: {'Content-Type': 'multipart/form-data'},
  //       ),
  //     );

  //     if (response.statusCode == 200 && response.data['text'] != null) {
  //       List textList = response.data['text'];
  //       final idRegExp = RegExp(r'\d{9}');
  //       for (var line in textList) {
  //         final match = idRegExp.firstMatch(line);
  //         if (match != null) {
  //           return match.group(0); // الرقم الوطني
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print("OCR error: $e");
  //     Get.snackbar("خطأ", "فشل في قراءة صورة الهوية");
  //   }

  //   return null;
  // }

  void register() async {
    // if (backId.value == null) {
    //   Get.snackbar("خطأ", "يرجى رفع صورة الهوية الخلفية");
    //   return;
    // }

    // final extractedId = await extractIdFromBackId(backId.value!);

    // if (extractedId == null) {
    //   Get.snackbar("خطأ", "تعذر قراءة الرقم الوطني من صورة الهوية");
    //   return;
    // }

    // if (extractedId != nationalIDController.text.trim()) {
    //   Get.snackbar("خطأ في الرقم الوطني", "الرقم الوطني لا يطابق الصورة");
    //   return;
    // }

    final request = RegisterRequestModel(
      name: firstNameController.text,
      email: emailController.text,
      password: passwordController.text,
      phone: phoneController.text,
      sex: selectedGender.value,
      idNumber: nationalIDController.text,
      governorate: selectedCity.value,
      city: locationCityController.text,
      avatar: avatar.value,
      frontId: frontId.value,
      backId: backId.value,
    );

    final res = await _repo.register(request);
    res.fold(
          (error) => Get.snackbar("فشل التسجيل", error.toString()),
          (success) => Get.snackbar("تم التسجيل", success),
    );
  }
}
