import 'package:get/get.dart';

import '../../models/deputy_model/post_view_model.dart';
import '../../models/deputy_model/story_model.dart';
import '../../repository/deputy_repository/deputy_home_repository.dart';

class DeputyHomeController extends GetxController {
  final DeputyHomeRepository repository;

  DeputyHomeController({required this.repository});

  var stories = <StoryModel>[].obs;
  var posts = <PostViewModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final fetchedStories = await repository.fetchStories();
      final fetchedPosts = await repository.fetchPosts();

      stories.assignAll(fetchedStories);
      posts.assignAll(fetchedPosts);
    } catch (e) {
      print('Error loading data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewStory(String mediaPath, String mediaType) async {
    try {
      await repository.addStory(mediaPath, mediaType);
      await loadData(); 
    } catch (e) {
      print('Error adding story: $e');
    }
  }

  void markStoryAsViewed(StoryModel story) {
    final index = stories.indexOf(story);
    if (index != -1) {
      stories[index].isViewed = true;
      stories.refresh();
    }
  }
}
