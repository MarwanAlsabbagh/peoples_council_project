import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/ellection_controller/party_controller.dart';
import '../../widgets/member_card.dart';
import '../../widgets/video_palyer_widget.dart';

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
        title: const Text(
          "التفاصيل",
          style: TextStyle(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/syria-logo-png_seeklogo-613100 1.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "سوريا نحو الأمل",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 16,
                  top: 130,
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Obx(() {
                      return GestureDetector(
                        onTap: () => partyController.toggleFollow(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF2E8F5A)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                partyController.isFollowed.value
                                    ? Icons.check
                                    : Icons.add,
                                color: Color(0xFF2E8F5A),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                partyController.isFollowed.value
                                    ? 'متابع'
                                    : 'متابعة',
                                style: const TextStyle(
                                  color: Color(0xFF2E8F5A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("المقر: ",
                          style: TextStyle(color: Color(0xff2E8F5A))),
                      Text(governorate),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("عدد الأعضاء: ",
                          style: TextStyle(color: Color(0xff2E8F5A))),
                      const SizedBox(width: 4),
                      Text('$numberOfMember'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => partyController.changeSelectedButton("حول الحزب"),
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: partyController.selectedButton.value ==
                                  'حول الحزب'
                                  ? const Color(0xff2E8F5A)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          "حول الحزب",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                            partyController.selectedButton.value == 'حول الحزب'
                                ? const Color(0xff2E8F5A)
                                : Colors.black,
                          ),
                        ),
                      )),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => partyController.changeSelectedButton("اعضاء الحزب"),
                      child: Obx(() => Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: partyController.selectedButton.value ==
                                  'اعضاء الحزب'
                                  ? const Color(0xff2E8F5A)
                                  : Colors.transparent,
                              width: 3,
                            ),
                          ),
                        ),
                        child: Text(
                          "اعضاء الحزب",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                            partyController.selectedButton.value == 'اعضاء الحزب'
                                ? const Color(0xff2E8F5A)
                                : Colors.black,
                          ),
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Obx(() {
                    if (partyController.selectedButton.value == 'حول الحزب') {
                      final articles = partyController.partyDetails.value?.articles ?? [];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("معلومات عن الحزب :",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2E8F5A))),
                          const Text("تاريخ التأسيس :  1-1-1996",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const Text("المقر :  دمشق ",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          Text("عدد الأعضاء : $numberOfMember",
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          const SizedBox(height: 10),
                          const Text("فيديوهات :",
                              style: TextStyle(
                                  color: Color(0xff2E8F5A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 200,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: partyController
                                  .partyDetails.value?.videoUrls.length ??
                                  0,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: VideoPlayerWidget(
                                    videoUrl: partyController
                                        .partyDetails.value!.videoUrls[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text("مقالات :",
                              style: TextStyle(
                                  color: Color(0xff2E8F5A),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: 250,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: articles.length,
                              itemBuilder: (context, index) {
                                final article = articles[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    width: 200,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          article.image,
                                          fit: BoxFit.cover,
                                          width: 200,
                                          height: 120,
                                          errorBuilder: (context, error, stackTrace) =>
                                          const Icon(Icons.error, color: Colors.red),
                                        ),
                                        Text(article.title,
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        Text(article.date,
                                            style: const TextStyle(
                                                fontSize: 14, color: Colors.grey)),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("الأمين العام للحزب :",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2E8F5A))),
                          const SizedBox(height: 10),
                          if (partyController.partyDetails.value != null)
                          MemberCard(
                          name: partyController.partyDetails.value!.generalSecretary.name,
                          imagePath: partyController.partyDetails.value!.generalSecretary.imagePath??"",
                          category: partyController.partyDetails.value!.generalSecretary.category,
                          governorate: partyController.partyDetails.value!.generalSecretary.governorate,
                          party: partyController.partyDetails.value!.generalSecretary.partyName ,
                          partyLogoPath: partyController.partyDetails.value!.generalSecretary.partyLogoPath,
                          )
                          else
                    Text('لا توجد بيانات للأمين العام'),
                          const SizedBox(height: 10),
                          const Text("أعضاء الحزب :",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff2E8F5A))),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: partyController.members.length,
                            itemBuilder: (context, index) {
                              final member = partyController.members[index];
                              return MemberCard(
                                name: member.name??"",
                                governorate: member.governorate??"",
                                category: member.category??"",
                                party: member.partyName??"" ,
                                imagePath: member.imagePath??"",
                                partyLogoPath: member.partyLogoPath??"",
                              );
                            },
                          ),
                        ],
                      );
                    }
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
