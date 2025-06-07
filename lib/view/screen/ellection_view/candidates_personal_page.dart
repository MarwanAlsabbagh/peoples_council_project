import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/ellection_controller/cardidates_personal_controller.dart';
import '../../widgets/video_palyer_widget.dart';

class CandidatesPersonalPage extends StatelessWidget {
  final String name;
  final String governorate;
  final String party;
  final String imagePath;
  final String partyLogoPath;
  final int id;

  const CandidatesPersonalPage({
    super.key,
    required this.name,
    required this.governorate,
    required this.party,
    required this.imagePath,
    required this.partyLogoPath,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final CandidatesController controller = Get.put(CandidatesController(id: id));

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
/*
                  Align(
                    alignment: Alignment.topLeft,
                    child:Obx(() {
                      return GestureDetector(
                        onTap: () {
                          controller.toggleFollow();
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: const Color(0xFF2E8F5A)),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                controller.isFollowed.value ? Icons.check : Icons.add,
                                color: Color(0xFF2E8F5A),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                controller.isFollowed.value ? 'متابع' : 'متابعة',
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
*/
                  Text(
                    name,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("المحافظة: ", style: TextStyle(color: Color(0xff2E8F5A))),
                      Text(governorate),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text("الحزب: ", style: TextStyle(color: Color(0xff2E8F5A))),
                      Image.asset(partyLogoPath, width: 20),
                      const SizedBox(width: 4),
                      Text(party),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),
            Obx(() {
              return Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedButton.value = 'حول المرشح';
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.selectedButton.value == 'حول المرشح'
                                    ? const Color(0xff2E8F5A)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            "حول المرشح",
                            style: TextStyle(
                              fontSize: 16,
                              color: controller.selectedButton.value == 'حول المرشح'
                                  ? const Color(0xff2E8F5A)
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedButton.value = 'البرنامج الانتخابي';
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.selectedButton.value == 'البرنامج الانتخابي'
                                    ? const Color(0xff2E8F5A)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            "البرنامج الانتخابي",
                            style: TextStyle(
                              fontSize: 16,
                              color: controller.selectedButton.value == 'البرنامج الانتخابي'
                                  ? const Color(0xff2E8F5A)
                                  : Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Obx(() {
                    return controller.selectedButton.value == 'حول المرشح'
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "معلومات عن المرشح:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        Text("تاريخ الميلاد: ${controller.candidate.value?.birthDate ?? ''}",
                            style: const TextStyle(fontSize: 16)),
                        Text("مكان الولادة: ${controller.candidate.value?.birthPlace ?? ''}",
                            style: const TextStyle(fontSize: 16)),
                        Text("المؤهل العلمي: ${controller.candidate.value?.education ?? ''}",
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 10),
                        const Text(
                          "فيديوهات:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.candidate.value?.videoUrls.length ?? 0,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: VideoPlayerWidget(
                                    videoUrl: controller.candidate.value?.videoUrls[index] ?? ''),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "مقالات:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.candidate.value?.articles.length ?? 0,
                            itemBuilder: (context, index) {
                              final article = controller.candidate.value?.articles[index];
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Container(
                                  width: 180,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        article?.image ?? "",
                                        width: 180,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(article?.title ?? "",
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold)),
                                            const SizedBox(height: 4),
                                            Text(article?.date ?? "",
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                        : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "البرنامج الانتخابي:",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        SizedBox(height: 8),
                        //Text(controller.candidate.value?.program ?? 'لا يوجد برنامج'),
                      ],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
