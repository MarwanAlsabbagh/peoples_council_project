import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String? governorate;
  final String? category;
  final String? party;
  final String? imagePath;
  final String? partyLogoPath;

  const MemberCard({
    Key? key,
    required this.name,
    this.governorate,
    this.category,
    this.party,
     this.imagePath,
    this.partyLogoPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFE4E7EC),
          width: 1,
        ),
      ),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imagePath!,
                width: double.infinity,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                if (governorate != null || category != null)
                  Wrap(
                    spacing: 12,
                    runSpacing: 4,
                    children: [
                      if (governorate != null) _infoLabel("المحافظة:", governorate!),
                      if (category != null) _infoLabel("الفئة:", category!),
                    ],
                  ),
                const SizedBox(height: 6),
                if (party != null && partyLogoPath != null)
                  Row(
                    children: [
                      const Text(
                        "الحزب:",
                        style: TextStyle(fontSize: 14, color: Color(0xff2E8F5A)),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(
                        partyLogoPath!,
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        party!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),

    );
  }

  Widget _infoLabel(String title, String value) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: Color(0xff2E8F5A),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}