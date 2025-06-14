import 'dart:io';

import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../models/ellection_model/votting_model.dart';
import '../../service/api_service.dart';

class VotingRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<List<Votting>> fetchCandidates() async {
    final response = await apiService.get('/getCandidates',withToken: false);
    print("Response from /getCandidates: ${response.data}");

    final List data = response.data['candidates'];

    return data.map((item) => Votting.fromJson(item)).toList();
  }

  // نوقف التحقق بالوجه مؤقتاً
  Future<bool> verifyFace(File imageFile) async {
    // return true; // ممكن تفعيل التعليق لتجاوز التحقق
    throw UnimplementedError('Face verification is disabled.');
  }

  Future<bool> submitVote(int candidateId) async {
    final response = await apiService.post('/vote', data: {'candidate_id': candidateId});
    return response.statusCode == 200;
  }
}
