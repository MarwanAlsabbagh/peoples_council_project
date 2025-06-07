import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../models/deputy_model/post_create_model.dart';
import '../../repository/deputy_repository/post_repository.dart';

class PostController extends GetxController {
  final content = ''.obs;
  final pickedMedia = Rxn<XFile>(); // صورة أو فيديو
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();

  final PostRepository _repository = PostRepository();

  Future<void> pickImage(ImageSource source) async {
    final file = await ImagePicker().pickImage(source: source);
    if (file != null) {
      pickedMedia.value = file;
    }
  }

  Future<void> pickVideo(ImageSource source) async {
    final file = await ImagePicker().pickVideo(source: source);
    if (file != null) {
      pickedMedia.value = file;
    }
  }

  bool get isVideo {
    final path = pickedMedia.value?.path.toLowerCase() ?? '';
    return path.endsWith('.mp4') || path.endsWith('.mov') || path.endsWith('.avi');
  }

  Future<void> submitPost() async {
    if ((content.value.isEmpty) && (pickedMedia.value == null)) {
      Get.snackbar('خطأ', 'يجب إدخال نص أو اختيار صورة/فيديو');
      return;
    }

    isLoading.value = true;

    final model = PostCreateModel(
      content: content.value.isNotEmpty ? content.value : null,
      mediaPath: pickedMedia.value?.path,
    );

    try {
      await _repository.createPost(model);
      Get.back(result: true);
    } catch (e) {
      Get.snackbar('خطأ', 'فشل في إرسال المنشور');
    } finally {
      isLoading.value = false;
    }
  }
  void reset() {
    content.value = '';
    pickedMedia.value = null;
    isLoading.value = false;
    formKey.currentState?.reset();
  }
}
