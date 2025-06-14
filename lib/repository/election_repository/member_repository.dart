import 'package:get/get.dart';
import '../../models/ellection_model/member_model.dart';
import '../../service/api_service.dart';

class MembersRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<List<MemberModel>> fetchMembers() async {
    final response = await apiService.get('/getCandidates',withToken: false);
    print("Response from /getCandidates: ${response.data}");
    final List data = response.data['candidates'];

    return data.map((item) => MemberModel.fromJson(item)).toList();
  }
}
