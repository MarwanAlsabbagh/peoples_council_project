import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart' as easy;

import '../../utils/globall_color.dart';

class ImageGenericWidget extends StatelessWidget {
  final String label;
  final XFile? image;
  final void Function(XFile) onPick;

  const ImageGenericWidget({
    super.key,
    required this.label,
    required this.image,
    required this.onPick,
  });

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();

    final selectedSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(easy.tr('choose_image_source')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title:  Text(easy.tr('take_photo')),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title:  Text(easy.tr('from_gallery')),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    if (selectedSource != null) {
      try {
        final pickedFile = await picker.pickImage(
          source: selectedSource,
          imageQuality: 85,
        );

        if (pickedFile != null) {
          final file = File(pickedFile.path);

          if (await file.exists()) {
            debugPrint("✅ تم اختيار صورة: ${pickedFile.path}");
            onPick(pickedFile);
          } else {
            debugPrint("⚠️ لم يتم العثور على الملف بعد اختياره");
            ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(easy.tr('image_load_error'))),
            );
          }
        }
      } catch (e) {
        debugPrint("⚠️ خطأ في اختيار الصورة: $e");
        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text(easy.tr('image_pick_error'))),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style:TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color:Color(0xff2E8F5A),
            )),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickImage(context),
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle,
            ),
            child: image == null
                ? const Icon(Icons.photo_album_sharp,
                size: 30, color: Color((0xff2E8F5A)))
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      File(image!.path),
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) =>
                          const Icon(Icons.broken_image),
                    ),
                  ),
          ),
        )
      ],
    );
  }
}
