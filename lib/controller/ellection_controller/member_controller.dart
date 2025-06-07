import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/ellection_model/member_model.dart';
import '../../repository/election_repository/member_repository.dart';

class MembersController extends GetxController {
  final MembersRepository repository = Get.find<MembersRepository>();

  RxList<MemberModel> members = <MemberModel>[].obs;
  RxList<MemberModel> filteredMembers = <MemberModel>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchData();

    searchController.addListener(() {
      filterMembers(searchController.text);
    });
  }

  void fetchData() async {
    try {
      final fetchedMembers = await repository.fetchMembers();
      members.assignAll(fetchedMembers);
      filteredMembers.assignAll(fetchedMembers);
    } catch (e) {
      print("خطأ في جلب الأعضاء: $e");
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
