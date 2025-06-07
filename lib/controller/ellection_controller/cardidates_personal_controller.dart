import 'package:get/get.dart';
import '../../models/ellection_model/candidate_model.dart';
import '../../repository/election_repository/candidate_repository.dart';

class CandidatesController extends GetxController {
  var candidate = Rx<CandidateModel?>(null);
  final int id;

  CandidateRepository candidateRepository = Get.find<CandidateRepository>();

  CandidatesController({required this.id});

  @override
  void onInit() {
    super.onInit();
    fetchCandidate(id);
  }

  Future<void> fetchCandidate(int id) async {
    candidate.value = await candidateRepository.fetchCandidate(id);
  }

  RxString selectedButton = 'حول المرشح'.obs;


}
