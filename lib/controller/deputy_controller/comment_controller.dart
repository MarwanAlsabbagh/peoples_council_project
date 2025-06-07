import 'package:get/get.dart';

import '../../models/deputy_model/comment_model.dart';
import '../../repository/deputy_repository/comment_repository.dart';

class CommentController extends GetxController {
  final CommentRepository repository;
  final int postId;

  CommentController({required this.repository, required this.postId});

  var comments = <CommentModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadComments();
  }

  Future<void> loadComments() async {
    try {
      isLoading.value = true;
      final fetchedComments = await repository.fetchComments(postId);
      comments.assignAll(fetchedComments);
    } catch (e) {
      print('Error loading comments: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addComment(String text) async {
    if (text.trim().isEmpty) return;
    try {
      await repository.addComment(postId, text);
      await loadComments();
    } catch (e) {
      print('Error adding comment: $e');
    }
  }
}
