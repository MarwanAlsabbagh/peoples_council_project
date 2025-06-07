import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VideoGenericWidget extends StatelessWidget {
  final String label;
  final XFile? video;
  final void Function(XFile) onPick;

  const VideoGenericWidget({
    super.key,
    required this.label,
    required this.video,
    required this.onPick,
  });

  Future<void> _pickVideo(BuildContext context) async {
    final picker = ImagePicker();

    final selectedSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر مصدر الفيديو'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.videocam),
                title: const Text('تصوير فيديو'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.video_library),
                title: const Text('اختيار فيديو من المعرض'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (selectedSource != null) {
      final pickedFile = await picker.pickVideo(source: selectedSource);
      if (pickedFile != null) {
        onPick(pickedFile);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileName = video != null ? File(video!.path).uri.pathSegments.last : "لم يتم اختيار فيديو";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickVideo(context),
          child: Container(
            width: double.infinity,
            height: 100,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                const Icon(Icons.video_file, size: 40),
                const SizedBox(width: 10),
                Expanded(child: Text(fileName, overflow: TextOverflow.ellipsis)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
