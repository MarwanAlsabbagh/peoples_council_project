import 'package:get/get.dart';

import '../../controller/create_new_password_controller.dart';
import '../../repository/reset_password_repository.dart';

class CreateNewPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateNewPasswordController>(() => CreateNewPasswordController());
  }
}