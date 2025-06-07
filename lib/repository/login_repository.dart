import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:get_storage/get_storage.dart';

import '../models/user_login.dart';
import '../service/api_service.dart';

class LoginRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();
  final box = GetStorage();

  Future<bool> login(UserLogin user) async {
    try {
      final response = await apiService.post('/login', data: user.toJson(),withToken: false);

      if (response.statusCode == 200) {
        final responseData = response.data;
        final userData = responseData['user'];

        box.write('token', responseData['token']);
        box.write('user', responseData['user']);
        box.write('role', userData['userable_type']);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Login failed: ${e.toString()}");
    }
  }
}
