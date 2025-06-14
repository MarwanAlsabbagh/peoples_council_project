import 'package:final_senior_project/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/clasefication_controller.dart';
import '../../../models/classification_models.dart';

class ClassificationPage extends StatelessWidget {
  final ClassificationController controller = Get.find<ClassificationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar(),
      body: Obx(() {
        if (controller.casesByCategory.isEmpty) {
          return Center(child: Text('لا توجد قضايا بعد.'));
        }

        return DefaultTabController(
          length: controller.casesByCategory.length,
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                labelColor: Color(0xFF2E8F5A), // لون النص المحدد
                unselectedLabelColor: Colors.grey, // لون النص غير المحدد
                indicatorColor: Color(0xFF2E8F5A), // لون الخط السفلي
                indicatorWeight: 3, // سماكة الخط
                labelStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 16,
                ),
                tabs: controller.casesByCategory.keys
                    .map((category) => Tab(text: category))
                    .toList(),
              ),
              Expanded(
                child: TabBarView(
                  children: controller.casesByCategory.values
                      .map((caseList) => _buildList(caseList))
                      .toList(),
                ),
              ),
            ],
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final text = await _showInputDialog(context);
          if (text != null && text.trim().isNotEmpty) {
            Get.dialog(
              Center(child: CircularProgressIndicator()),
              barrierDismissible: false,
            );
            try {
              await controller.classifyAndAddCase(text);
            } catch (e) {
              Get.snackbar('خطأ', 'فشل التصنيف: $e');
            } finally {
              Get.back();
            }
          }
        },
        backgroundColor: Color(0xFF2E8F5A), // خلفية الزر
        child: Icon(Icons.add, color: Colors.white),),
    );
  }

  Widget _buildList(List<ClassificationModel> cases) {
    if (cases.isEmpty) {
      return Center(child: Text('لا توجد قضايا حالياً'));
    }

    return ListView.builder(
      itemCount: cases.length,
      itemBuilder: (context, index) {
        final caseItem = cases[index];
        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            title: Text(caseItem.title, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4),
                Text(caseItem.description),
                SizedBox(height: 8),
                Text(
                  '${caseItem.date.day}/${caseItem.date.month}/${caseItem.date.year}',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String?> _showInputDialog(BuildContext context) async {
    String? inputText;

    return await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // شعار ونص
                Column(
                  children: [
                    Image.asset(
                      'assets/syria-logo-png_seeklogo-613100 1.png',
                      height: 80,
                      width: 80,
                    ),
                    const Text(
                      "مجلس الشعب السوري",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Syrian People's Assembly",
                      style: TextStyle(
                          color: Color(0xff2E8F5A),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                const Text(
                  "أدخل نص القضية",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2E8F5A),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  autofocus: true,
                  minLines: 2,
                  maxLines: 4,

                  onChanged: (value) => inputText = value,
                  decoration:InputDecoration(
                  hintText: 'مثال: يخضع هذا الاتفاق...',
                  contentPadding: EdgeInsets.all(12),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E8F5A)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF2E8F5A), width: 2.0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

        ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Color(0xffF53D6B),
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: const Text(
                          "إلغاء",
                          style: TextStyle(
                            color: Color(0xffF53D6B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xff2E8F5A),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          "تصنيف",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(inputText),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
