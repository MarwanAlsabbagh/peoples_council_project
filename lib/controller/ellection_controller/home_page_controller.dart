import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/ellection_model/ellection_home_page_model.dart';
import '../../repository/election_repository/election_home_repository.dart';

class ElectionHomeController extends GetxController {
  final ElectionHomeRepository repository = Get.find<ElectionHomeRepository>();

  var searchText = ''.obs;
  TextEditingController searchController = TextEditingController();

  var days = "00".obs;
  var hours = "00".obs;
  var minutes = "00".obs;
  var seconds = "00".obs;

  var electionEndDate = DateTime.now().add(Duration(days: 10)).obs;
  late Timer countdownTimer;

  var currentIndex = 0.obs;
  var electionData = ElectionHomeModel(
    name: '',
    email: '',
    avatar: '',
    candidateCount: 0,
    totalVotes: 0,
  ).obs;

  // قائمة ثابتة للمحافظات
  final List<String> governorates = [
    "دمشق",
    "ريف دمشق",
    "حلب",
    "حمص",
    "حماه",
    "اللاذقية",
    "طرطوس",
    "دير الزور",
    "الحسكة",
    "الرقة",
    "السويداء",
    "درعا",
    "القنيطرة",
    "إدلب"
  ];

  void startCountdown() {
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      final difference = electionEndDate.value.difference(now);

      if (difference.isNegative) {
        timer.cancel();
        days.value = hours.value = minutes.value = seconds.value = "00";
      } else {
        days.value = difference.inDays.toString().padLeft(2, '0');
        hours.value = (difference.inHours % 24).toString().padLeft(2, '0');
        minutes.value = (difference.inMinutes % 60).toString().padLeft(2, '0');
        seconds.value = (difference.inSeconds % 60).toString().padLeft(2, '0');
      }
    });
  }

  void changeGovernorate(bool isNext) {
    if (isNext) {
      currentIndex.value = (currentIndex.value + 1) % governorates.length;
    } else {
      currentIndex.value = (currentIndex.value - 1 + governorates.length) % governorates.length;
    }
  }

  Future<void> loadElectionData() async {
    try {
      final results = await repository.fetchElectionResults();
      electionData.value = results;
    } catch (e) {
      print("خطأ في جلب بيانات الانتخابات: $e");
    }
  }

  @override
  void onInit() {
    super.onInit();
    startCountdown();
    loadElectionData();
  }

  @override
  void onClose() {
    countdownTimer.cancel();
    searchController.dispose();
    super.onClose();
  }
}