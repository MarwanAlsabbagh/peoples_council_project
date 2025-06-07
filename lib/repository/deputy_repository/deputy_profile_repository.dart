import 'package:get/get.dart';
import '../../models/deputy_model/deputy_profile_model.dart';
import '../../service/api_service.dart';

class DeputyProfileRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<DeputyProfileModel> fetchDeputyProfile() async {
    final response = await _apiService.get('/candidate-profile',withToken: true);
    final Map<String, dynamic> data = response.data;
    return DeputyProfileModel.fromJson(data);
  }

 /* Future<void> followDeputy() async {
    await _apiService.post('/profile/follow');
  }

  Future<void> unfollowDeputy() async {
    await _apiService.post('/profile/unfollow');
  }*/
}
