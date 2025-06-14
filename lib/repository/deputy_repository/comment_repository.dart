import 'package:dio/dio.dart';

import '../../models/deputy_model/comment_model.dart';
import '../../service/api_service.dart';

class CommentRepository {
  final ApiService apiService;

  CommentRepository({required this.apiService});

  Future<List<CommentModel>> fetchComments(int postId) async {
    final response = await apiService.get('/posts/$postId/comment');
    final data = response.data as List;
    return data.map((json) => CommentModel.fromJson(json)).toList();
  }

  Future<void> addComment(int postId, String commentText) async {
    await apiService.post('/posts/$postId/comment', data: {'comment': commentText});
  }
}
