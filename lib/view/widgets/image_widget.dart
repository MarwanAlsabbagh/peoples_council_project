import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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

    // عرض حوار لاختيار بين الكاميرا والمعرض
    final selectedSource = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('اختر مصدر الصورة'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('التقاط صورة من الكاميرا'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
              ListTile(
                leading: const Icon(Icons.photo_album),
                title: const Text('اختيار صورة من المعرض'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
            ],
          ),
        );
      },
    );

    // إذا اختار المستخدم مصدرًا، التقط الصورة
    if (selectedSource != null) {
      final pickedFile = await picker.pickImage(source: selectedSource);
      if (pickedFile != null) {
        onPick(pickedFile); // إعادة الصورة المختارة إلى الـ onPick
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _pickImage(context), // تمرير context هنا
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: image == null
                ? const Icon(Icons.camera_alt_outlined)
                : Image.file(File(image!.path), fit: BoxFit.cover),
          ),
        )
      ],
    );
  }
}
