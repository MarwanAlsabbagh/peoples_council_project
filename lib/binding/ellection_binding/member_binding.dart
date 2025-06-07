import 'package:get/get.dart';
import '../../controller/ellection_controller/member_controller.dart';



class memberPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MembersController());

  }
}