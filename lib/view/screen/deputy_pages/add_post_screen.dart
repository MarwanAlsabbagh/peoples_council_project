import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../../controller/deputy_controller/post_controller.dart';
import '../../../utils/globall_color.dart';
import '../../../utils/media_picker_helper.dart';
import '../../widgets/eleveted_button.dart';
import '../../widgets/media_preview_widget.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PostController>();

    return Scaffold(
      appBar: AppBar(
        title:  Text(easy.tr('create_post'), style: TextStyle(color: Colors.white)),
        backgroundColor: GlobalColors.mainColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Obx(() => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 26,
                      backgroundImage: AssetImage('assets/images/user_avatar.png'),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: TextFormField(
                          maxLines: null,
                          onChanged: (val) => controller.content.value = val,
                          decoration:  InputDecoration(
                            hintText: easy.tr('what_are_you_thinking'),
                            border: InputBorder.none,
                            isDense: true,
                          ),
                          validator: (val) {
                            if ((val == null || val.isEmpty) &&
                                controller.pickedMedia.value == null) {
                              return easy.tr('content_or_media_required');
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MediaPreviewWidget(controller: controller),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _mediaIcon(
                      icon: Icons.image,
                      label: easy.tr('image'),
                      onTap: () async {
                        final source = await MediaPickerHelper.pickMediaSource(context, isVideo: false);
                        if (source != null) await controller.pickImage(source);
                      },
                    ),
                    _mediaIcon(
                      icon: Icons.videocam,
                      label: easy.tr('video'),
                      onTap: () async {
                        final source = await MediaPickerHelper.pickMediaSource(context, isVideo: true);
                        if (source != null) await controller.pickVideo(source);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ButtonWidget(
                  text: controller.isLoading.value ? easy.tr('posting') : easy.tr('post'),
                  onPressed: controller.isLoading.value ? null : controller.submitPost,
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }

  Widget _mediaIcon({required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: onTap,
      splashColor: GlobalColors.mainColor.withOpacity(0.3),
      child: Column(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: GlobalColors.mainColor.withOpacity(0.15),
            child: Icon(icon, color: GlobalColors.mainColor, size: 28),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
