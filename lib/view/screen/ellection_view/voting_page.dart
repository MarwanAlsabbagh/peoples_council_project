import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import '../../../controller/ellection_controller/votting_controller.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/eleveted_button.dart';
import '../../widgets/search_bar_with_filter.dart';
import '../../widgets/voting_card.dart';

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
                onFilterPressed: () {},
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
                  return  Expanded(
                    child: Center(child: Text(easy.tr('no_matching_candidates'))),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredCandidates.length,
                    itemBuilder: (context, index) {
                      final candidate = controller.filteredCandidates[index];

                      return Obx(() {
                        final isSelected = controller.isCandidateSelected(candidate);

                        return VotingCard(
                          name: candidate.name ?? '',
                          governorate: candidate.governorate ?? '',
                          category: candidate.category ?? '',
                          party: candidate.partyName ?? '',
                          imagePath: candidate.imagePath ?? '',
                          partyLogoPath: candidate.partyLogoPath ?? '',
                          isSelected: isSelected,
                          onSelected: (selected) {
                            if (selected) {
                              controller.selectCandidate(candidate);
                            } else {
                              controller.deselectCandidate();
                            }
                          },
                        );
                      });
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),
              Obx(() => SizedBox(
                width: double.infinity,
                child: ButtonWidget(
                  text: easy.tr('vote'),
                  onPressed: controller.selectedCandidate.value != null
                      ? () async {
                    final success = await controller.submitVote();
                    Get.snackbar(
                      success ? easy.tr('vote_success_title') :easy.tr('vote_failure_title'),
                      success
                          ?easy.tr('vote_success_message')
                          :easy.tr('vote_failure_message'),
                      snackPosition: SnackPosition.BOTTOM,
                    );
                    if (success) {
                      controller.deselectCandidate();
                    }
                  }
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
