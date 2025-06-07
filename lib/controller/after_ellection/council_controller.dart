import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/aftter_ellection/council_member_model.dart';
import '../../repository/aftter_ellection/council_repository.dart';
import '../../service/api_service.dart';

class CouncilController extends GetxController {
  final CouncilRepository repository = Get.find<CouncilRepository>();

  var members = <CouncilMember>[].obs;
  var filteredMembers = <CouncilMember>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadMembers();
    searchController.addListener(() {
      filterMembers(searchController.text);
    });
  }

  Future<void> loadMembers() async {
    try {
      final loadedMembers = await repository.fetchMembers();
      members.assignAll(loadedMembers);
      filteredMembers.assignAll(loadedMembers);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  void filterMembers(String query) {
    if (query.isEmpty) {
      filteredMembers.assignAll(members);
    } else {
      filteredMembers.assignAll(
        members.where((member) => member.name.contains(query)).toList(),
      );
    }
  }
}
