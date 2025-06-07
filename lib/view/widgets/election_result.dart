import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/ellection_controller/home_page_controller.dart';

class ElectionResultsCard extends StatelessWidget {
  const ElectionResultsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final ElectionHomeController controller = Get.find<ElectionHomeController>();

    return Obx(() {
      final selectedGovernorate = controller.governorates[controller.currentIndex.value];
      final data = controller.electionData.value;

      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Color(0xffF7F7F8),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset("assets/syria-logo-png_seeklogo-613100 1.png", width: 100, height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30),
                  onPressed: () => controller.changeGovernorate(false),
                ),
                Text(
                  selectedGovernorate,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.keyboard_arrow_left, color: Colors.green, size: 30),
                  onPressed: () => controller.changeGovernorate(true),
                ),
              ],
            ),
            Divider(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 84,
                    width: 160,
                    padding:const EdgeInsets.all(8.0),
                    color: Color(0xffFFFFFF),
                    child: _infoCard("عدد الأصوات الكلي", "${data.totalVotes} صوت", Colors.black)),
                Container(
                    height: 84,
                    width: 160,
                    color: Color(0xffFFFFFF),
                    padding:const EdgeInsets.all(8.0),

                    child: _infoCard("عدد المرشحين الكلي", "${data.candidateCount} مرشح", Colors.black)),
              ],
            ),
            SizedBox(height: 10),
            _progressBar(data.totalVotes, data.candidateCount * 100, Colors.green, "نسبة التصويت في الانتخابات :"),
          ],
        ),
      );
    });
  }

  Widget _infoCard(String title, String value, Color color) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: Color(0xff2E8F5A), fontSize: 18)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontSize: 18)),
      ],
    );
  }

  Widget _progressBar(int value, int total, Color color, String label) {
    double percentage = total != 0 ? (value / total) : 0.0;
    return Container(
      color: Color(0xffFFFFFF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 18,color: Color(0xff2E8F5A))),
          SizedBox(height: 6),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(color),
          ),
          SizedBox(height: 8),
          Text("${(percentage * 100).toStringAsFixed(0)}%", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}