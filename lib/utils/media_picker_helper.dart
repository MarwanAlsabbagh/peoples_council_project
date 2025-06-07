import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MediaPickerHelper {
  static Future<ImageSource?> pickMediaSource(BuildContext context, {required bool isVideo}) {
    return showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isVideo ? 'اختر مصدر الفيديو' : 'اختر مصدر الصورة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(isVideo ? Icons.videocam : Icons.camera_alt),
                title: Text(isVideo ? 'تصوير فيديو' : 'التقاط صورة'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: Icon(isVideo ? Icons.video_library : Icons.photo_album),
                title: const Text('اختيار من المعرض'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );
  }
}
