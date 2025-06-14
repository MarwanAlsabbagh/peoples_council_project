import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:get_storage/get_storage.dart'; // ⬅️ تم إضافتها لقراءة role من التخزين

import '../../../controller/deputy_controller/deputy_home_controller.dart';
import '../../widgets/add_story_circle.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/story_circle.dart';
import '../story_viwer.dart';

class DeputyHomePage extends StatelessWidget {
  DeputyHomePage({super.key});

  final DeputyHomeController controller = Get.find();

  final String? role = GetStorage().read('role');

  Future<void> _addNewStory(BuildContext context) async {
    final picker = ImagePicker();

    final mediaType = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(easy.tr('choose_story_type')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: Text(easy.tr('story_type_image')),
                onTap: () => Navigator.pop(context, 'image'),
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: Text(easy.tr('story_type_video')),
                onTap: () => Navigator.pop(context, 'video'),
              ),
              ListTile(
                leading: const Icon(Icons.text_fields),
                title: Text(easy.tr('story_type_text')),
                onTap: () => Navigator.pop(context, 'text'),
              ),
            ],
          ),
        );
      },
    );

    if (mediaType == null) return;

    String? mediaPath;

    if (mediaType == 'image' || mediaType == 'video') {
      final source = await showDialog<ImageSource>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(easy.tr('choose_source')),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: Text(easy.tr('source_camera')),
                  onTap: () => Navigator.pop(context, ImageSource.camera),
                ),
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: Text(easy.tr('source_gallery')),
                  onTap: () => Navigator.pop(context, ImageSource.gallery),
                ),
              ],
            ),
          );
        },
      );

      if (source == null) return;

      final pickedFile = mediaType == 'image'
          ? await picker.pickImage(source: source)
          : await picker.pickVideo(source: source);

      if (pickedFile == null) return;

      mediaPath = pickedFile.path;
    }

    final content = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: Text(easy.tr('enter_optional_text')),
          content: TextField(
            controller: controller,
            maxLines: 3,
            decoration: InputDecoration(hintText: easy.tr('story_text_hint')),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, null),
              child: Text(easy.tr('skip')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, controller.text.trim()),
              child: Text(easy.tr('done')),
            ),
          ],
        );
      },
    );

    if ((mediaPath == null || mediaPath.isEmpty) && (content == null || content.isEmpty)) {
      return;
    }

    await controller.addNewStory(mediaPath ?? '', content);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: CustomAppBar(),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final sortedStories = [
            ...controller.stories.where((s) => !s.isViewed),
            ...controller.stories.where((s) => s.isViewed),
          ];

          return SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Row(
                      children: [
                        if (role == 'CandidateDetail') ...[
                          AddStoryCircle(
                            onTap: () => _addNewStory(context),
                          ),
                          const SizedBox(width: 10),
                        ],
                        ...sortedStories.map((story) {
                          return GestureDetector(
                            onTap: () async {
                              final viewed = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoryViewer(
                                    stories: controller.stories,
                                    initialIndex: controller.stories.indexOf(story),
                                  ),
                                ),
                              );
                              if (viewed == true) {
                                controller.markStoryAsViewed(story);
                              }
                            },
                            child: StoryCircle(
                              imagePath: story.ownerImage,
                              userName: story.ownerName,
                              isViewed: story.isViewed,
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                Column(
                  children: controller.posts.map((post) {
                    return PostWidget(post: post);
                  }).toList(),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
