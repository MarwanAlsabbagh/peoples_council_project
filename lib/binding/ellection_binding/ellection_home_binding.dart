import 'package:get/get.dart';

import '../../controller/ellection_controller/home_page_controller.dart';
import '../../controller/login_controller.dart';
import '../../repository/login_repository.dart';
import '../../service/api_service.dart';


class EllectionHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ElectionHomeController());

  }
}