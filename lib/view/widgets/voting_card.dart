import 'package:flutter/material.dart';

class VotingCard extends StatelessWidget {
  final String name;
  final String? governorate;
  final String? category;
  final String? party;
  final String imagePath;
  final String? partyLogoPath;
  final bool isSelected;
  final void Function(bool selected) onSelected;

  const VotingCard({
    super.key,
    required this.name,
    this.governorate,
    this.category,
    this.party,
    required this.imagePath,
    this.partyLogoPath,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xff2E8F5A) : const Color(0xFFE4E7EC),
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة المرشح
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),

            // معلومات المرشح
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  if (governorate != null || category != null)
                    Wrap(
                      spacing: 12,
                      children: [
                        if (governorate != null) _infoLabel("المحافظة:", governorate!),
                        if (category != null) _infoLabel("الفئة:", category!),
                      ],
                    ),
                  const SizedBox(height: 6),
                  if (party != null && partyLogoPath != null)
                    Row(
                      children: [
                        Image.asset(partyLogoPath!, width: 20, height: 20),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            party!,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),

            // مؤشر الاختيار ✅
            Icon(
              isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: isSelected ? const Color(0xff2E8F5A) : Colors.grey,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoLabel(String title, String value) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xff2E8F5A), fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 4),
        Text(value, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
