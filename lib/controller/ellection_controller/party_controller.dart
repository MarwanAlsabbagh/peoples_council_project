import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../models/ellection_model/member_model.dart';
import '../../models/ellection_model/party_personal_model.dart';
import '../../repository/election_repository/party_personal_repository.dart';

class PartyController extends GetxController {
  var selectedButton = 'حول الحزب'.obs;
  var partyDetails = Rx<PartyPersonalModel?>(null);
  var members = <MemberModel>[].obs;

  final int id;
  final PartyRepository partyRepository = Get.find<PartyRepository>();

  PartyController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchPartyDetails(id);
  }

  void fetchPartyDetails(int id) async {
    try {
      partyDetails.value = await partyRepository.fetchPartyDetails(id);
      members.value = await partyRepository.fetchPartyMembers(id);
      isFollowed.value = partyDetails.value?.isFollowed ?? false;
    } catch (e) {
      print('خطأ في جلب بيانات الحزب: $e');
    }
  }

  RxBool isFollowed = false.obs;

  Future<void> toggleFollow() async {
    if (partyDetails.value != null) {
      isFollowed.value = !isFollowed.value;
      partyDetails.value!.isFollowed = isFollowed.value;

      try {
        await partyRepository.updateFollowStatus(id, isFollowed.value);
      } catch (e) {
        Get.snackbar("خطأ", "فشل في تحديث حالة المتابعة");
      }
    }
  }
    void changeSelectedButton(String button) {
      selectedButton.value = button;
    }
  }
