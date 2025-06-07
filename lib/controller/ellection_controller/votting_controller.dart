import 'dart:io';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../models/ellection_model/votting_model.dart';
import '../../repository/election_repository/voting_repository.dart';

class VotingController extends GetxController {
  final VotingRepository repository = Get.find<VotingRepository>();

  RxList<Votting> candidates = <Votting>[].obs;
  RxList<Votting> filteredCandidates = <Votting>[].obs;
  Rx<Votting?> selectedCandidate = Rx<Votting?>(null);
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCandidates();
  }

  void fetchCandidates() async {
    isLoading.value = true;
    try {
      final data = await repository.fetchCandidates();
      candidates.value = data;
      filteredCandidates.value = data;
    } finally {
      isLoading.value = false;
    }
  }

  void filterCandidates(String query) {
    if (query.isEmpty) {
      filteredCandidates.value = candidates;
      return;
    }

    filteredCandidates.value = candidates.where((candidate) {
      return candidate.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }

  bool isCandidateSelected(Votting candidate) {
    return selectedCandidate.value?.name == candidate.name;
  }

  void selectCandidate(Votting candidate) {
    selectedCandidate.value = candidate;
  }

  void deselectCandidate() {
    selectedCandidate.value = null;
  }

  Future<bool> verifyFace(File imageFile) async {
    return await repository.verifyFace(imageFile);
  }

  Future<bool> submitVote() async {
    final name = selectedCandidate.value?.name;
    if (name == null) return false;
    return await repository.submitVote(name);
  }
}