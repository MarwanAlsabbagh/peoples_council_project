import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/deputy_model/post_create_model.dart';
import '../../service/api_service.dart';

class PostRepository {
  final ApiService _apiService = Get.find<ApiService>();

  Future<void> createPost(PostCreateModel post) async {
    final formData = dio.FormData();

    if (post.content != null && post.content!.isNotEmpty) {
      formData.fields.add(MapEntry('content', post.content!));
    }

    if (post.mediaPath != null && post.mediaPath!.isNotEmpty) {
      formData.files.add(MapEntry(
        'media',
        await dio.MultipartFile.fromFile(post.mediaPath!),
      ));
    }

    await _apiService.postMultipart('/posts', formData);
  }
}
