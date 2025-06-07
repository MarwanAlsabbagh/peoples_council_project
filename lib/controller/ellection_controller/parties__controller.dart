import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/ellection_model/parties_model.dart';
import '../../repository/election_repository/parties_repository.dart';

class PartiesController extends GetxController {
  final PartiesRepository repository = Get.find<PartiesRepository>();

  RxList<PartiesModel> parties = <PartiesModel>[].obs;
  RxList<PartiesModel> filteredParties = <PartiesModel>[].obs;

  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchParties();

    searchController.addListener(() {
      filterParties(searchController.text);
    });
  }

  void fetchParties() async {
    try {
      final data = await repository.fetchParties();
      parties.assignAll(data);
      filteredParties.assignAll(data);
    } catch (e) {
      print("فشل في جلب بيانات الأحزاب: $e");
    }
  }

  void filterParties(String query) {
    if (query.isEmpty) {
      filteredParties.assignAll(parties);
    } else {
      filteredParties.assignAll(
        parties.where((party) => party.name.contains(query)).toList(),
      );
    }
  }
}
