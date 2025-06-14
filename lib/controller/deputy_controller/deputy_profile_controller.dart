import 'package:get/get.dart';
import '../../models/deputy_model/deputy_profile_model.dart';
import '../../models/deputy_model/post_view_model.dart';
import '../../models/deputy_model/profile_post_model.dart';
import '../../repository/deputy_repository/deputy_profile_repository.dart';

class ProfileController extends GetxController {
  final user = DeputyProfileModel.empty().obs;
  final posts = <ProfilePostModel>[].obs;
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

      print("👀 loadProfile: Before API call");
      final deputyProfile = await _repository.fetchDeputyProfile();
      print("✅ loadProfile: After API call");

      user.value = deputyProfile;
      posts.assignAll(deputyProfile.posts);

    } catch (e, stacktrace) {
      print("❌ Error loading profile: $e");
      print("❌ Stacktrace: $stacktrace");
    } finally {
      isLoading.value = false;
    }
  }


  void addNewPost(ProfilePostModel post) {
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
