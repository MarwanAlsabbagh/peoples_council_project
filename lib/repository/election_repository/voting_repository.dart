
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/state_manager.dart';

import '../../models/ellection_model/votting_model.dart';
import '../../service/api_service.dart';

class VotingRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<List<Votting>> fetchCandidates() async {
    final response = await apiService.get('/candidates');
    return (response.data as List).map((json) => Votting.fromJson(json)).toList();
  }

  Future<bool> verifyFace(File imageFile) async {
    final formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imageFile.path, filename: 'face.jpg'),
    });

    final response = await apiService.postMultipart('/face-verification', formData);
    return response.data['verified'] == true;
  }

  Future<bool> submitVote(String candidateName) async {
    final response = await apiService.post('/vote', data: {'candidate_name': candidateName});
    return response.statusCode == 200;
  }
}
