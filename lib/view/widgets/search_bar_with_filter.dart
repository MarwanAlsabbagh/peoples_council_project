import 'package:flutter/material.dart';

class SearchBarWithFilter extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onFilterPressed;
  final ValueChanged<String>? onChanged;
  const SearchBarWithFilter({
    Key? key,
    required this.controller,
    required this.onFilterPressed,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // 🔹 حقل البحث أولاً (ليكون على اليمين)
          Expanded(
            child: TextField(
              onChanged: onChanged,
              controller: controller,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: "ابحث عن ما تريد...",
                prefixIcon: const Icon(Icons.search, color: Colors.green),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.green),
            onPressed: onFilterPressed,
          ),
        ],
      ),
    );
  }
}