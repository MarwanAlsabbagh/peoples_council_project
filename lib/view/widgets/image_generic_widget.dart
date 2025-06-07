/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/register_controller.dart';
import '../../utils/globall_color.dart';
import 'dialog_widget.dart';

class ImagePickerWidget extends StatelessWidget {
  final RegisterController controller = Get.find();

  ImagePickerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      DecorationImage? decorationImage;
      if (controller.personImage.value != null &&
          File(controller.personImage.value!.path).existsSync()) {
        decorationImage = DecorationImage(
          image: FileImage(File(controller.personImage.value!.path)),
          fit: BoxFit.cover,
        );
      }

      return Stack(
        children: [
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DialogWidget(
                    onCameraTap: () {
                      controller.pickImage(ImageSource.camera);
                      Get.back();
                    },
                    onGalleryTap: () {
                      controller.pickImage(ImageSource.gallery);
                      Get.back();
                    },
                    cameraText: "قم باختيار صورة من الكاميرا",
                    galleryText: "قم باختيار صورة من المعرض",
                    mainText: 'اختر صورة شخصية',
                  );
                },
              );
            },
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                image: decorationImage,
              ),
              child: controller.personImage.value == null
                  ? Center(
                child: Icon(
                  Icons.image,
                  color: GlobalColors.mainColor,
                  size: 50,
                ),
              )
                  : null,
            ),
          ),
        ],
      );
    });
  }
}
*/
