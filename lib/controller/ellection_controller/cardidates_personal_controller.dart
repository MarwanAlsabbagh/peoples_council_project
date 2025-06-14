import 'package:get/get.dart';
import '../../models/ellection_model/candidate_model.dart';
import '../../repository/election_repository/candidate_repository.dart';

class CandidatesController extends GetxController {
  var candidate = Rxn<CandidateModel>();
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final int id;
  final CandidateRepository candidateRepository = Get.find<CandidateRepository>();

  CandidatesController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchCandidate(id);
  }

  Future<void> fetchCandidate(int id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      candidate.value = await candidateRepository.fetchCandidate(id);
    } catch (e) {
      errorMessage.value = e.toString();
      candidate.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  RxString selectedButton = 'about_candidate'.obs;
}
