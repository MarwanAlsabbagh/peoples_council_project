import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:path/path.dart';
import 'package:dartz/dartz.dart';

import '../models/register_model.dart';
import '../service/api_service.dart';

class RegisterRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<Either<String, String>> register(RegisterRequestModel request) async {
    try {
      dio.FormData formData = dio.FormData.fromMap({
        'name': request.name,
        'email': request.email,
        'password': request.password,
        'phone': request.phone,
        'sex': request.sex,
        'id_number': request.idNumber,
        'governorate': request.governorate,
        'city': request.city,
        if (request.avatar != null)
          'avatar': await dio.MultipartFile.fromFile(
            request.avatar!.path,
            filename: basename(request.avatar!.path),
          ),
        if (request.frontId != null)
          'front_id': await dio.MultipartFile.fromFile(
            request.frontId!.path,
            filename: basename(request.frontId!.path),
          ),
        if (request.backId != null)
          'back_id': await dio.MultipartFile.fromFile(
            request.backId!.path,
            filename: basename(request.backId!.path),
          ),
      });

      final res = await apiService.post("/register", data: formData,withToken: false);

      if (res.statusCode == 200) {
        return Right(res.data["message"] ?? "تم بنجاح");
      } else if (res.statusCode == 400) {
        return Left("خطأ في المدخلات: ${res.data["message"] ?? "تفاصيل غير محددة"}");
      } else if (res.statusCode == 500) {
        return Left("حدث خطأ في الخادم، يرجى المحاولة لاحقًا.");
      } else {
        return Left("استجابة غير متوقعة من الخادم.");
      }
    }
    catch (e, stacktrace) {
      print("Error: $e");
      print("Stacktrace: $stacktrace");
      Get.snackbar("خطأ", "حدث خطأ أثناء التسجيل، يرجى المحاولة لاحقًا.");
      return Left("خطأ أثناء التسجيل: ${e.toString()}");
    }
  }
}
