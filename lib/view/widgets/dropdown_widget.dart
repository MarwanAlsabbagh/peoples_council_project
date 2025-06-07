import 'package:flutter/material.dart';

import '../../utils/globall_color.dart';

class DropdownWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  final List<String> items;
  final String? selectedValue;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  const DropdownWidget({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: selectedValue?.isEmpty == true ? null : selectedValue,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            prefixIcon: Icon(prefixIcon,  color:Color(0xFF8A8AA3) ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: GlobalColors.mainColor, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
            filled: false,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
        ),
      ],
    );
  }
}
