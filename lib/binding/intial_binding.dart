import 'package:get/get.dart';

import '../../controller/create_new_password_controller.dart';
import '../../controller/send_instructions_controller.dart';
import '../../repository/reset_password_repository.dart';
import '../../repository/rigister_reposetory.dart';
import '../../repository/send_instructions_repository.dart';
import '../../service/api_service.dart';
import '../controller/after_ellection/chat_controller.dart';
import '../controller/clasefication_controller.dart';
import '../controller/deputy_controller/deputy_home_controller.dart';
import '../controller/deputy_controller/post_controller.dart';
import '../controller/ellection_controller/party_controller.dart';
import '../controller/ellection_controller/votting_controller.dart';
import '../controller/login_controller.dart';
import '../controller/notification_controller.dart';
import '../controller/register_controller.dart';
import '../repository/aftter_ellection/chat_repository.dart';
import '../repository/classification_repository.dart';
import '../repository/deputy_repository/deputy_home_repository.dart';
import '../repository/deputy_repository/post_repository.dart';
import '../repository/election_repository/candidate_repository.dart';
import '../repository/election_repository/election_home_repository.dart';
import '../repository/election_repository/member_repository.dart';
import '../repository/election_repository/parties_repository.dart';
import '../repository/election_repository/party_personal_repository.dart';
import '../repository/election_repository/voting_repository.dart';
import '../repository/login_repository.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ApiService());
    Get.put(LoginRepository());
    Get.put(RegisterRepository());
    Get.put(ElectionHomeRepository());
    Get.put(SendInstructionsRepository());
    Get.put(ResetPasswordRepository());
    Get.put(MembersRepository());
    Get.put(PartiesRepository());
    Get.put(CandidateRepository());
    Get.put(ChatRepository());
    Get.put(VotingRepository());
    Get.put(PostRepository());
    Get.put(DeputyHomeRepository());
    Get.put(PartyRepository());

    Get.put(ClassificationRepository());
    Get.put(ClassificationController(repository: Get.find()));

    Get.put(LoginController());
    Get.put(CreateNewPasswordController());
    Get.put(RegisterController());
    Get.put(SendInstructionsController());
    Get.put(ChatController());
    Get.put(VotingController());
    Get.put(NotificationController());
    Get.put(PostController());
    Get.put(DeputyHomeController());
    //Get.put(PartyController());


  }
}
