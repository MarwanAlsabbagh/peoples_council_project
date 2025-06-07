import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controller/deputy_controller/deputy_home_controller.dart';
import '../../../models/deputy_model/story_model.dart';
import '../../widgets/add_story_circle.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/story_circle.dart';
import '../story_viwer.dart';

class DeputyHomePage extends StatelessWidget {
  DeputyHomePage({super.key});

  final DeputyHomeController controller = Get.find();

  Future<void> _addNewStory(BuildContext context) async {
    final picker = ImagePicker();
    final media = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('إضافة Story'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('صورة'),
                onTap: () => Navigator.pop(context, 'image'),
              ),
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('فيديو'),
                onTap: () => Navigator.pop(context, 'video'),
              ),
            ],
          ),
        );
      },
    );

    if (media == 'image') {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        await controller.addNewStory(pickedFile.path, 'image');
      }
    } else if (media == 'video') {
      final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
      if (pickedFile != null) {
        await controller.addNewStory(pickedFile.path, 'video');
      }
    }
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
                // 🟠 قصص
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    child: Row(
                      children: [
                        AddStoryCircle(
                          onTap: () => _addNewStory(context),
                        ),
                        const SizedBox(width: 10),
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
                              imagePath: story.mediaUrl,
                              userName: story.userName,
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
