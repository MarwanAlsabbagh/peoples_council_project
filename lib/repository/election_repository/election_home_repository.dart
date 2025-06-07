import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

import '../../models/ellection_model/ellection_home_page_model.dart';
import '../../service/api_service.dart';


class ElectionHomeRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<ElectionHomeModel> fetchElectionResults() async {
    try {
      final response = await apiService.get('/home');
      print('API Response: ${response.statusCode} - ${response.data}');

      if (response.statusCode == 200) {
        return ElectionHomeModel.fromJson(response.data);
      } else {
        throw Exception('API Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in fetchElectionResults: $e');
      throw Exception('Failed to load data. Please try again.');
    }
  }
 /*   Future<DateTime> fetchElectionDate() async {
      final response = await apiService.get('/election/date');

      final data = response.data;
      return DateTime.parse(data['election_date']);
    }*/
  }
