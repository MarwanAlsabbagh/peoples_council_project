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

    final Map<String, dynamic> data = response.data;

    return CandidateModel.fromJson(data);
  }
}
