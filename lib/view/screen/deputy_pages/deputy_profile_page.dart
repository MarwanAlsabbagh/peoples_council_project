import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/deputy_controller/deputy_profile_controller.dart';
import '../../../controller/deputy_controller/post_controller.dart';
import '../../../models/deputy_model/deputy_profile_model.dart';
import '../../../models/deputy_model/post_view_model.dart';
import '../../../models/deputy_model/profile_post_model.dart';
import '../../../utils/media_utils.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/post_widget_profile.dart';
import 'add_post_screen.dart';

class DeputyProfilePage extends StatelessWidget {
  final ProfileController controller = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final user = controller.user.value;
        return SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: [
                _buildHeader(user),
                const SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          Text(user.description,
                              style: const TextStyle(
                                  fontSize: 16, color: Color(0xff2E8F5A))),
                        ],
                      ),
                      const Spacer(),
                      /*GestureDetector(
                        onTap: controller.toggleFollowStatus,
                        child: Obx(() {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 26, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                              Border.all(color: const Color(0xFF2E8F5A)),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              controller.isFollowing.value
                                  ? 'إلغاء المتابعة'
                                  : 'متابعة',
                              style: const TextStyle(
                                  color: Color(0xFF2E8F5A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          );
                        }),
                      ),*/
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _StatItem(
                        label: easy.tr('profile_posts'),
                        count: user.postsCount),
                    const SizedBox(width: 20),
                    _StatItem(
                        label: easy.tr('profile_likes'),
                        count: user.totalLikes),
                    const SizedBox(width: 20),
                    // _StatItem(label: 'المتابعين', count: user.followers),
                  ],
                ),
                const SizedBox(height: 16),
                ...controller.posts
                    .map((post) => PostWidgetProfile (post: post))
                    .toList(),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final postController = Get.find<PostController>();
          postController.reset();

          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => AddPostScreen()),
          );

          if (result != null && result is Map<String, dynamic>) {
            final newPost = ProfilePostModel.fromJson(result);
            controller.addNewPost(newPost);
          }

        },
        backgroundColor: const Color(0xFF2E8F5A),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }

  Widget _buildHeader(DeputyProfileModel user) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(height: 160, color: const Color(0xFF2E8F5A)),
        Positioned.fill(
          child: Image.asset('assets/Vector (5).png', fit: BoxFit.cover),
        ),
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Image.asset('assets/syria-logo-png_seeklogo-613100 1.png',
                  width: 60, height: 60),
              const SizedBox(height: 8),
              Text(
                easy.tr("syria_towards_hope"),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: -40,
          right: 6,
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              getFullMediaUrl(user.image),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('$count',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label),
      ],
    );
  }
}
