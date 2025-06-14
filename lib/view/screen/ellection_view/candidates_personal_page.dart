import 'package:final_senior_project/view/screen/ellection_view/pdf_viewer_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/ellection_controller/cardidates_personal_controller.dart';
import '../../../utils/media_utils.dart';
import '../../widgets/video_palyer_widget.dart';

class CandidatesPersonalPage extends StatelessWidget {
  final int id;

  const CandidatesPersonalPage({
    super.key,
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
        title: Text(
          easy.tr("details_title"),
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
            Obx(() {
              if (controller.isLoading.value) {
                return const SizedBox(
                  height: 180,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (controller.errorMessage.isNotEmpty) {
                return SizedBox(
                  height: 180,
                  child: Center(child: Text(controller.errorMessage.value)),
                );
              }
              if (controller.candidate.value == null) {
                return SizedBox(
                  height: 180,
                  child: Center(child: Text(easy.tr('no_data'))),
                );
              }

              final candidate = controller.candidate.value!;
              final party = candidate.party;

              return Stack(
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
                      child: candidate.imagePath.startsWith('http')
                          ? Image.network(
                        candidate.imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : Image.asset(
                        candidate.imagePath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(() {
                final candidate = controller.candidate.value;
                if (candidate == null) {
                  return Container();
                }
                final party = candidate.party;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      candidate.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(easy.tr("governorate"), style: const TextStyle(color: Color(0xff2E8F5A))),
                        const SizedBox(width: 6),
                        Text(candidate.party?.city ?? ''),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Text(easy.tr("party"), style: const TextStyle(color: Color(0xff2E8F5A))),
                        const SizedBox(width: 6),
                        if (party != null)
                          party.imageUrl.startsWith('http')
                              ? Image.network(
                            party.imageUrl,
                            width: 20,
                          )
                              : Image.asset(
                            party.imageUrl,
                            width: 20,
                          ),
                        const SizedBox(width: 4),
                        Text(party?.name ?? ''),
                      ],
                    ),
                  ],
                );
              }),
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
                          controller.selectedButton.value = 'about_candidate';
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.selectedButton.value == 'about_candidate'
                                    ? const Color(0xff2E8F5A)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            easy.tr('about_candidate'),
                            style: TextStyle(
                              fontSize: 16,
                              color: controller.selectedButton.value == 'about_candidate'
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
                          controller.selectedButton.value = 'election_program';
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: controller.selectedButton.value == 'election_program'
                                    ? const Color(0xff2E8F5A)
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Text(
                            easy.tr('election_program'),
                            style: TextStyle(
                              fontSize: 16,
                              color: controller.selectedButton.value == 'election_program'
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
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.errorMessage.isNotEmpty) {
                    return Center(child: Text(controller.errorMessage.value));
                  }

                  if (controller.candidate.value == null) {
                    return Center(child: Text(easy.tr('no_data')));
                  }

                  final candidate = controller.candidate.value!;

                  return SingleChildScrollView(
                    child: controller.selectedButton.value == 'about_candidate'
                        ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          easy.tr("candidate_info"),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${easy.tr("birth_date")}: ${candidate.birthDate}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${easy.tr("birth_place")}: ${candidate.birthPlace}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        Text(
                          "${easy.tr("education")}: ${candidate.education}",
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          easy.tr("videos"),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: candidate.videoUrls.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: VideoPlayerWidget(
                                    videoRelativePath: candidate.videoUrls[index]),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          easy.tr("articles"),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2E8F5A)),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 220,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: candidate.articles.length,
                            itemBuilder: (context, index) {
                              final article = candidate.articles[index];

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PdfViewerPage(pdfUrl: article.pdfPath),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: 180,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      boxShadow: const [
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
                                        article.image.startsWith('http')
                                            ? Image.network(
                                          article.image,
                                          width: 180,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        )
                                            : Image.asset(
                                          article.image,
                                          width: 180,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            article.title,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 14),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text(
                                            article.date,
                                            style:
                                            const TextStyle(color: Colors.grey, fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )

                      ],
                    )
                        : Text(
                      candidate.electoralProgram,
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
