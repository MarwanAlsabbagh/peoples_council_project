import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final String cameraText;
  final String galleryText;
  final String mainText;

  const DialogWidget(
      {required this.onCameraTap,
        required this.onGalleryTap,
        required this.cameraText,
        required this.galleryText,
        required this.mainText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(mainText),
      content: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.camera),
            title: Text(cameraText),
            onTap: () {
              onCameraTap();
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: Text(galleryText),
            onTap: () {
              onGalleryTap();
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }
}