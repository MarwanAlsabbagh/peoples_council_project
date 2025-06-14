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

      return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: const Color(0xffF7F7F8),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                spreadRadius: 2,
                offset: const Offset(0, 3),
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
                    icon: const Icon(Icons.keyboard_arrow_right, color: Colors.green, size: 30),
                    onPressed: () => controller.changeGovernorate(false),
                  ),
                  Text(
                    selectedGovernorate,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_left, color: Colors.green, size: 30),
                    onPressed: () => controller.changeGovernorate(true),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 84,
                    width: 160,
                    padding: const EdgeInsets.all(8.0),
                    color: const Color(0xffFFFFFF),
                    child: _infoCard("عدد الأصوات الكلي", "${data.totalVotes} صوت", Colors.black),
                  ),
                  Container(
                    height: 84,
                    width: 160,
                    color: const Color(0xffFFFFFF),
                    padding: const EdgeInsets.all(8.0),
                    child: _infoCard("عدد المرشحين ", "${data.candidateCount} مرشح", Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              _progressBar(data.totalVotes, data.candidateCount * 100, Colors.green, "نسبة التصويت في الانتخابات :"),
            ],
          ),
        ),
      );
    });
  }

  Widget _infoCard(String title, String value, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: const TextStyle(color: Color(0xff2E8F5A), fontSize: 18)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontSize: 18)),
      ],
    );
  }

  Widget _progressBar(int value, int total, Color color, String label) {
    double percentage = total != 0 ? (value / total) : 0.0;
    return Container(
      color: const Color(0xffFFFFFF),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 18, color: Color(0xff2E8F5A))),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: percentage,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text("${(percentage * 100).toStringAsFixed(0)}%", style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
