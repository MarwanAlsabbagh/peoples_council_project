import 'package:flutter/material.dart';

class ElectionCountdown extends StatelessWidget {
  final String days;
  final String hours;
  final String minutes;
  final String seconds;

  const ElectionCountdown({
    super.key,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF7F7F8),
        borderRadius: BorderRadius.circular(12),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "الوقت المتبقي للانتخابات :",
                      style: TextStyle(
                        color: Color(0xff2E8F5A),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "الإنتخابات العامة لمجلس الشعب الدورة التشريعية 2024",
                      style: TextStyle(
                        color: Color(0xff000401),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(
                "assets/syria-logo-png_seeklogo-613100 1.png",
                height: 40,
                width: 40,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimeBox(days, "الأيام"),
              _buildTimeBox(hours, "الساعات"),
              _buildTimeBox(minutes, "الدقائق"),
              _buildTimeBox(seconds, "الثواني"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(String value, String label) {
    return Expanded(
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: const Color(0x1A2E8F5A),
          border: Border.all(
            color: const Color(0xFF2E8F5A),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4), // قلل الهامش
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
