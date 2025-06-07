import 'package:get/get.dart';
import '../../controller/ellection_controller/parties__controller.dart';



class partiesPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(PartiesController());

  }
}