import 'package:get/get.dart';
import '../../controller/ellection_controller/votting_controller.dart';

class VotingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VotingController>(() => VotingController());
  }
}