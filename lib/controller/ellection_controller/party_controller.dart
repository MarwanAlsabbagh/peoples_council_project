import 'package:get/get.dart';
import '../../models/ellection_model/member_model.dart';
import '../../models/ellection_model/party_personal_model.dart';
import '../../repository/election_repository/party_personal_repository.dart';

class PartyController extends GetxController {
  var selectedButton = 'حول الحزب'.obs;
  var partyDetails = Rx<PartyPersonalModel?>(null);

  // غيّر نوع members ليكون قائمة PartyCandidate بدلاً من MemberModel
  var candidates = <PartyCandidate>[].obs;

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
      candidates.value = partyDetails.value?.candidates ?? [];
    } catch (e) {
      print('خطأ في جلب بيانات الحزب: $e');
    }
  }

  void changeSelectedButton(String button) {
    selectedButton.value = button;
  }
}

