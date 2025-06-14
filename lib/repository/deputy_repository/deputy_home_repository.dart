import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../../models/deputy_model/post_view_model.dart';
import '../../models/deputy_model/story_model.dart';
import '../../service/api_service.dart';

class DeputyHomeRepository {
  final ApiService apiService = Get.find<ApiService>();

  Future<List<StoryModel>> fetchStories() async {
    try {
      final response = await apiService.get('/candidate/homeFeed');
      final data = response.data['statuses'];
      if (data is List) {
        return data.map((json) => StoryModel.fromJson(json)).toList();
      }
      print('⚠️ No "statuses" key or not a list');
      return [];
    } catch (e) {
      print('❌ fetchStories error: $e');
      return [];
    }
  }

  Future<List<PostViewModel>> fetchPosts() async {
    try {
      final response = await apiService.get('/candidate/homeFeed');
      final data = response.data['posts'];
      if (data is List) {
        return data.map((json) => PostViewModel.fromJson(json)).toList();
      }
      print('⚠️ No "posts" key or not a list');
      return [];
    } catch (e) {
      print('❌ fetchPosts error: $e');
      return [];
    }
  }

  Future<void> addStory(String mediaPath, String? content) async {
    final formMap = <String, dynamic>{};

    if (mediaPath.isNotEmpty) {
      formMap['media'] = await dio.MultipartFile.fromFile(mediaPath);
    }

    if (content != null && content.trim().isNotEmpty) {
      formMap['content'] = content.trim();
    }

    final formData = dio.FormData.fromMap(formMap);
    await apiService.postMultipart('/candidate/statuses', formData);
  }


}
