import 'package:get/get.dart';
import '../../models/ellection_model/member_model.dart';
import '../../models/ellection_model/party_personal_model.dart';
import '../../service/api_service.dart';

class PartyRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<PartyPersonalModel> fetchPartyDetails(int id) async {
    try {
      final response = await apiService.get('/parties/$id/candidates');
      return PartyPersonalModel.fromNewApi(response.data);
    } catch (e) {
      throw Exception('فشل في جلب بيانات الحزب: $e');
    }
  }

  Future<void> updateFollowStatus(int partyId, bool isFollowed) async {
    try {
      final response = await apiService.put(
        '/party_info/$partyId',
        data: {'is_followed': isFollowed},
      );
      print('تم تحديث حالة المتابعة بنجاح: ${response.data}');
    } catch (e) {
      throw Exception('فشل في تحديث حالة المتابعة: $e');
    }
  }


}
