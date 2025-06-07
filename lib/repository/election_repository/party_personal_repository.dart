import 'package:get/get.dart';
import '../../models/ellection_model/member_model.dart';
import '../../models/ellection_model/party_personal_model.dart';
import '../../service/api_service.dart';

class PartyRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<PartyPersonalModel> fetchPartyDetails(int id) async {
    try {
      final response = await apiService.get('/party_info/$id');
      return PartyPersonalModel.fromJson(response.data);
    } catch (e) {
      throw Exception('فشل في جلب بيانات الحزب: $e');
    }
  }

  Future<List<MemberModel>> fetchPartyMembers(int partyId) async {
    try {
      final response = await apiService.get('/party_members/$partyId');
      final List data = response.data as List;
      return data.map((e) => MemberModel.fromJson(e)).toList();
    } catch (e) {
      throw Exception('فشل في جلب بيانات الأعضاء: $e');
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
