import 'package:dio/dio.dart';

import '../../models/deputy_model/post_view_model.dart';
import '../../models/deputy_model/story_model.dart';
import '../../service/api_service.dart';

class DeputyHomeRepository {
  final ApiService apiService;

  DeputyHomeRepository({required this.apiService});

  Future<List<StoryModel>> fetchStories() async {
    final response = await apiService.get('/stories');
    final data = response.data as List;
    return data.map((json) => StoryModel.fromJson(json)).toList();
  }

  Future<List<PostViewModel>> fetchPosts() async {
    final response = await apiService.get('/posts');
    final data = response.data as List;
    return data.map((json) => PostViewModel.fromJson(json)).toList();
  }

  Future<void> addStory(String mediaPath, String mediaType) async {
    final formData = FormData.fromMap({
      'media': await MultipartFile.fromFile(mediaPath),
      'type': mediaType,
    });
    await apiService.postMultipart('/stories', formData);
  }
}
