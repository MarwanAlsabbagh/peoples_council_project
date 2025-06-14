import 'package:get/get.dart';
import '../../models/deputy_model/post_view_model.dart';
import '../../models/deputy_model/story_model.dart';
import '../../repository/deputy_repository/deputy_home_repository.dart';

class DeputyHomeController extends GetxController {
  final DeputyHomeRepository repository = Get.find<DeputyHomeRepository>();

  var stories = <StoryModel>[].obs;
  var posts = <PostViewModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }
  void addNewPost(PostViewModel newPost) {
    posts.insert(0, newPost);
  }

  Future<void> loadData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        repository.fetchStories(),
        repository.fetchPosts(),
      ]);

      stories.assignAll(results[0] as List<StoryModel>);
      posts.assignAll(results[1] as List<PostViewModel>);

      print('✅ Fetched ${stories.length} stories & ${posts.length} posts');
    } catch (e) {
      print('❌ Error loading data: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addNewStory(String mediaPath, String? content) async {
    await repository.addStory(mediaPath, content);
    await loadData();
  }

  void markStoryAsViewed(StoryModel story) {
    final index = stories.indexOf(story);
    if (index != -1) {
      stories[index].isViewed = true;
      stories.refresh();
    }
  }
}
