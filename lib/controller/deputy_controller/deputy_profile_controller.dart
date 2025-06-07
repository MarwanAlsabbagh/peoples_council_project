import 'package:get/get.dart';
import '../../models/deputy_model/deputy_profile_model.dart';
import '../../models/deputy_model/post_view_model.dart';
import '../../repository/deputy_repository/deputy_profile_repository.dart';

class ProfileController extends GetxController {
  final user = DeputyProfileModel.empty().obs;
  final posts = <PostViewModel>[].obs;
  final isLoading = false.obs;
  final isFollowing = false.obs;

  final _repository = DeputyProfileRepository();

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;

      // هنا استدعاء الدالة الموحدة
      final deputyProfile = await _repository.fetchDeputyProfile();

      user.value = deputyProfile;
      posts.assignAll(deputyProfile.posts ?? []);
     // isFollowing.value = deputyProfile.isFollowing ?? false;

    } catch (e) {
      print("Error loading profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void addNewPost(PostViewModel post) {
    posts.insert(0, post);
    user.update((val) {
      if (val != null) {
        user.value = val.copyWith(postsCount: val.postsCount + 1);
      }
    });
  }

/* تابع المتابعة اذا تريده
  Future<void> toggleFollowStatus() async {
    try {
      if (isFollowing.value) {
        await _repository.unfollowDeputy();
        user.update((val) => val?.followers -= 1);
      } else {
        await _repository.followDeputy();
        user.update((val) => val?.followers += 1);
      }
      isFollowing.toggle();
    } catch (e) {
      print("Error updating follow status: $e");
    }
  }
  */
}
