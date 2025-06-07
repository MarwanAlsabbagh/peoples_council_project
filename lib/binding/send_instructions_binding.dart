import 'package:get/get.dart';

import '../../controller/send_instructions_controller.dart';
import '../../repository/send_instructions_repository.dart';

class SendInstructionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendInstructionsController());
  }
}