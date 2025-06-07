import 'package:get/get.dart';

import '../../controller/after_ellection/chat_controller.dart';
import '../../repository/aftter_ellection/chat_repository.dart';
import '../../service/api_service.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => ChatRepository());
    Get.lazyPut(() => ChatController());
  }
}
