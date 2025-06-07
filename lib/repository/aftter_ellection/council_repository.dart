import 'package:get/get.dart';

import '../../models/aftter_ellection/council_member_model.dart';
import '../../service/api_service.dart';

class CouncilRepository {
  final ApiService apiService;

  CouncilRepository({required this.apiService});

  Future<List<CouncilMember>> fetchMembers() async {
    try {
      final response = await apiService.get('/council/members');
      final data = response.data as List;
      return data.map((json) => CouncilMember.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load council members: $e');
    }
  }
}
