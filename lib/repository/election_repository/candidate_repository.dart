import 'package:get/get.dart';
import '../../models/ellection_model/candidate_model.dart';
import '../../service/api_service.dart';

class CandidateRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<CandidateModel> fetchCandidate(int id) async {
    final response = await apiService.post(
      '/getCandidatesPage',
      data: {'id': id},
    );

    final List data = response.data as List;

    if (data.isNotEmpty) {
      return CandidateModel.fromJson(data.first);
    } else {
      throw Exception('لم يتم العثور على بيانات المرشح');
    }
  }

// 🟡 سيتم تفعيل هذا لاحقًا بعد دعم الـ Backend لحقل is_followed
/*
  Future<void> updateFollowStatus(int candidateId, bool isFollowed) async {
    try {
      final response = await apiService.put(
        '/candinate_info/$candidateId',
        data: {'is_followed': isFollowed},
      );
      print('Status updated successfully: ${response.data}');
    } catch (e) {
      throw Exception('فشل في تحديث حالة المتابعة: $e');
    }
  }
  */
}
