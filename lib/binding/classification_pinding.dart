import 'package:get/get.dart';
import '../controller/clasefication_controller.dart';
import '../repository/classification_repository.dart';

class ClassificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClassificationRepository>(() => ClassificationRepository());
    Get.lazyPut<ClassificationController>(
          () => ClassificationController(repository: Get.find<ClassificationRepository>()),
    );
  }
}
