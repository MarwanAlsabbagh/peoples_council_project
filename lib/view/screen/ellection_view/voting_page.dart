import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/ellection_controller/votting_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/eleveted_button.dart';
import '../../widgets/search_bar_with_filter.dart';
import '../../widgets/voting_card.dart';
import 'face_verification_page.dart';

class VotingPage extends StatelessWidget {
  VotingPage({super.key});

  final TextEditingController searchController = TextEditingController();
  final VotingController controller = Get.find<VotingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBarWithFilter(
                controller: searchController,
                onFilterPressed: () {}, // دالة غير قابلة للnull
                onChanged: (value) => controller.filterCandidates(value),
              ),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Expanded(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (controller.filteredCandidates.isEmpty) {
                  return const Expanded(
                    child: Center(child: Text('لا يوجد مرشحين متطابقين')),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredCandidates.length,
                    itemBuilder: (context, index) {
                      final candidate = controller.filteredCandidates[index];
                      final isSelected = controller.isCandidateSelected(candidate);

                      return VotingCard(
                        name: candidate.name,
                        governorate: candidate.governorate,
                        category: candidate.category,
                        party: candidate.party,
                        imagePath: candidate.imagePath,
                        partyLogoPath: candidate.partyLogoPath,
                        isSelected: isSelected,
                        onSelected: (selected) {
                          if (selected) {
                            controller.selectCandidate(candidate);
                          } else {
                            controller.deselectCandidate();
                          }
                        },
                      );
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  text: 'تصويت',
                  onPressed: controller.selectedCandidate.value != null
                      ? () => Get.to(() => const FaceVerificationPage())
                      : null,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}