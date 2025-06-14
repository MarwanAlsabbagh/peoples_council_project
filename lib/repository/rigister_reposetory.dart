import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

import '../models/register_model.dart';
import '../service/api_service.dart';

class RegisterRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<dio.FormData> _buildFormData(RegisterRequestModel request) async {
    final formMap = <String, dynamic>{
      'name': request.name,
      'email': request.email,
      'password': request.password,
      'phone': request.phone,
      'sex': request.sex,
      'id_number': request.idNumber,
      'governorate': request.governorate,
      'city': request.city,
    };

    Future<void> addFileIfExists(String fieldName, XFile? xfile) async {
      if (xfile != null) {
        final path = xfile.path;
        final mimeType = lookupMimeType(path);
        final mime = mimeType?.split('/');

        formMap[fieldName] = await dio.MultipartFile.fromFile(
          path,
          filename: basename(path),
          contentType: (mime != null)
              ? MediaType(mime[0], mime[1])
              : MediaType('application', 'octet-stream'),
        );
      }
    }

    await addFileIfExists('avatar', request.avatar);
    await addFileIfExists('front_id', request.frontId);
    await addFileIfExists('back_id', request.backId);
    print("===== FormData contents =====");
    formMap.forEach((key, value) {
      if (value is dio.MultipartFile) {
        print("$key: MultipartFile (filename: ${value.filename}, contentType: ${value.contentType})");
      } else {
        print("$key: $value");
      }
    });
    print("=============================");
    return dio.FormData.fromMap(formMap);
  }

  Future<dio.Response> registerUser(RegisterRequestModel request) async {
    final formData = await _buildFormData(request);
    return await _apiService.postMultipart('/register', formData, withToken: false);
  }
}
