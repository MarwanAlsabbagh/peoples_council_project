import 'package:get/get.dart';
import '../../controller/deputy_controller/post_controller.dart';

class PostBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(() => PostController());
  }
}
