import 'package:get/get.dart';
import '../models/reset_password_model.dart';  // استيراد الموديل
import '../service/api_service.dart';

class ResetPasswordRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<bool> resetPassword(ResetPasswordModel resetPasswordModel) async {
    try {
      final response = await apiService.post(
        '/resetPassword',
        data: resetPasswordModel.toJson(),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }
}
