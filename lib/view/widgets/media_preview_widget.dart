import 'dart:io';
import 'package:final_senior_project/view/widgets/video_generic_widget.dart';
import 'package:flutter/material.dart';

import '../../../controller/deputy_controller/post_controller.dart';

class MediaPreviewWidget extends StatelessWidget {
  final PostController controller;

  const MediaPreviewWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final media = controller.pickedMedia.value;

    if (media != null) {
      final isVideo = controller.isVideo;

      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            isVideo
                ? Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: VideoGenericWidget(
                label: 'تم اختيار فيديو',
                video: media,
                onPick: (_) => controller.pickedMedia.value = null,
              ),
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(File(media.path),
                  height: 220, width: double.infinity, fit: BoxFit.cover),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Colors.black54,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.redAccent, size: 20),
                  onPressed: () => controller.pickedMedia.value = null,
                ),
              ),
            )
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
