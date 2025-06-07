import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../controller/deputy_controller/deputy_home_controller.dart';
import '../../repository/deputy_repository/deputy_home_repository.dart';
import '../../service/api_service.dart';

class DeputyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiService());
    Get.lazyPut(() => DeputyHomeRepository(apiService: Get.find()));
    Get.lazyPut(() => DeputyHomeController(repository: Get.find()));
  }
}
