import 'package:get/get.dart';
import '../models/classification_models.dart';
import '../repository/classification_repository.dart';

class ClassificationController extends GetxController {
  final ClassificationRepository repository;

  ClassificationController({required this.repository});

  var casesByCategory = <String, RxList<ClassificationModel>>{}.obs;

  @override
  void onInit() {
    super.onInit();

    final sampleCase = ClassificationModel(
      title: 'اتفاقية خاضعة للقوانين',
      description: 'يخضع هذا الاتفاق لقوانين المملكة العربية السعودية',
      date: DateTime.now(),
    );

    casesByCategory['القوانين الحاكمة'] = <ClassificationModel>[sampleCase].obs;
  }


  Future<void> classifyAndAddCase(String text) async {
    final result = await repository.classifyText(text);

    final caseModel = ClassificationModel(
      title: 'عنوان القضية',
      description: text,
      date: DateTime.now(),
    );

    if (!casesByCategory.containsKey(result)) {
      casesByCategory[result] = <ClassificationModel>[].obs;
    }

    casesByCategory[result]!.add(caseModel);
  }
}
