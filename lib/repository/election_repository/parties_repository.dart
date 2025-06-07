import 'package:get/get.dart';
import '../../models/ellection_model/parties_model.dart';
import '../../service/api_service.dart';

class PartiesRepository extends GetxService {
  final ApiService apiService = Get.find<ApiService>();

  Future<List<PartiesModel>> fetchParties() async {
    final response = await apiService.get('/parties');
    final List data = response.data['parties'] as List;
    return data.map((e) => PartiesModel.fromJson(e)).toList();
  }

}
