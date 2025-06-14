import 'package:final_senior_project/view/screen/ellection_view/parties_personal_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import '../../../controller/ellection_controller/parties__controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/parties_card.dart';

class PartiesPage extends StatelessWidget {
  const PartiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PartiesController controller = Get.put(PartiesController());

    return Scaffold(
      appBar: const CustomAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.searchController,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  style: const TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: easy.tr("search_hint"),
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.filteredParties.length,
                    itemBuilder: (context, index) {
                      final party = controller.filteredParties[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => PartiesPeersonalPage(
                                id: party.id,
                                name: party.name,
                                governorate: party.governorate ?? "",
                                imagePath: party.imagePath ?? "",
                                numberOfMember: party.numberMembers,
                              ));
                        },
                        child: PartiesCard(
                          name: party.name??"",
                          governorate: party.governorate??"",
                          imagePath: party.imagePath??"",
                          numberMember: party.numberMembers??1,
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
