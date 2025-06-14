import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ellection_controller/party_controller.dart';
import '../../../utils/media_utils.dart';
import '../../widgets/member_card.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import 'candidates_personal_page.dart';

class PartiesPeersonalPage extends StatelessWidget {
  final String name;
  final String governorate;
  final String imagePath;
  final int id;
  final int numberOfMember;

  PartiesPeersonalPage({
    super.key,
    required this.name,
    required this.governorate,
    required this.imagePath,
    required this.id,
    required this.numberOfMember,
  });

  @override
  Widget build(BuildContext context) {
    final PartyController partyController = Get.put(PartyController(id: id));

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        title: Text(
          easy.tr('details_title'),
          style: const TextStyle(
            fontSize: 22,
            color: Color(0xff000401),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Color(0xff2E8F5A),
            size: 28,
          ),
        ),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  color: const Color(0xFF2E8F5A),
                  child: Stack(
                    children: [
                      // صورة الخلفية في الأسفل
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/Vector (5).png',
                          fit: BoxFit.cover,
                          height: 120,
                        ),
                      ),

                      // المحتوى الأساسي فوق الصورة
                      Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/syria-logo-png_seeklogo-613100 1.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              easy.tr("syria_towards_hope"),
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 130,
                  child: ClipOval(
                    child: Image.network(
                      getFullMediaUrl(imagePath),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error, size: 100, color: Colors.red),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(easy.tr("headquarters"),
                          style: const TextStyle(color: Color(0xff2E8F5A))),
                      const SizedBox(width: 4),
                      Text(governorate),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(easy.tr("members_count"),
                          style: const TextStyle(color: Color(0xff2E8F5A))),
                      const SizedBox(width: 4),
                      Text('$numberOfMember'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                if (partyController.candidates.isEmpty) {
                  return Center(
                    child: Text(easy.tr('no_party_members')),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: partyController.candidates.length,
                  itemBuilder: (context, index) {
                    final candidate = partyController.candidates[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => CandidatesPersonalPage(id: candidate.id));
                      },
                      child: MemberCard(
                        name: candidate.name,
                        governorate: candidate.governorate,
                        category: candidate.category,
                        party: partyController.partyDetails.value?.name ?? '',
                        imagePath: candidate.image,
                        partyLogoPath: partyController.partyDetails.value?.image != null
                            ? partyController.partyDetails.value!.image
                            : 'assets/syria-logo-png_seeklogo-613100 1.png',
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
