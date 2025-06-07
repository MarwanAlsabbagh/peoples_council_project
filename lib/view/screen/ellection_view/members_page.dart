import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/ellection_controller/member_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/member_card.dart';
import 'candidates_personal_page.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MembersController controller = Get.put(MembersController());

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
                    hintText: "ابحث عن ما تريد...",
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
                    itemCount: controller.filteredMembers.length,
                    itemBuilder: (context, index) {
                      final member = controller.filteredMembers[index];
                      return GestureDetector(
                        onTap: () {
                          Get.to(() => CandidatesPersonalPage(
                            id: member.id,
                            name: member.name,
                            governorate: member.governorate??"",
                            party: member.partyName ??"",
                            imagePath: member.imagePath??"",
                            partyLogoPath: member.partyLogoPath??"",
                          ));
                        },
                        child: MemberCard(
                          name: member.name ?? '',
                          governorate: member.governorate ?? '',
                          category: member.category ?? '',
                          party: member.partyName ?? '',
                          imagePath: member.imagePath ?? '',
                          partyLogoPath: member.partyLogoPath ?? '',
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